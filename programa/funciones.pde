//Funciones básicas

void fecha(){
  while(true){
  fecha = day()+"-"+month()+"-"+year();
  delay(60000);
  }
}
void hora(){
  while(true){
    hora = hour()+":"+minute()+":"+second();
    delay(1000);
  }
}
void actualizarFechaHora(){
  while(true){
  lblFechaActual.setText(fecha + "_" + hora);
  }
}

void conectar(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino conectado");
  }
  println("INFO:conectando al puerto:"+Serial.list()[lstPuertos.getSelectedIndex()]);
  ardu = new Arduino(this, Arduino.list()[lstPuertos.getSelectedIndex()], 57600);
  ardu.pinMode(bombaI, Arduino.OUTPUT);
  ardu.pinMode(bombaD, Arduino.OUTPUT);
  ardu.pinMode(ledBuzzer, Arduino.OUTPUT);
  ardu.pinMode(ledLuz, Arduino.OUTPUT);
  ardu.pinMode(puerta, Arduino.SERVO);
  ardu.pinMode(sensorI, Arduino.INPUT);
  ardu.pinMode(sensorD, Arduino.INPUT);
  ardu.pinMode(sensorE, Arduino.INPUT);
  ardu.servoWrite(puerta, angCierre);
  
  //This make arduino signal an ok connection
  delay(1000);
  ardu.digitalWrite(10,Arduino.HIGH);
  delay(100);
  ardu.digitalWrite(10,Arduino.LOW);
  delay(100);
  ardu.digitalWrite(10,Arduino.HIGH);
  delay(100);
  ardu.digitalWrite(10,Arduino.LOW);
  println("INFO:Exito");
  lblEstadoConexion.setText("conectado!");
}

void desconectar(){
  ardu.dispose();
  println("arduino disconnected!");
}

void agregarTextoArchivo(String filename, String text) {
  File f = new File(dataPath(filename));
  if (!f.exists()) {
    creaArchivo(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

void creaArchivo(File f) {
  File parentDir = f.getParentFile();
  try {
    parentDir.mkdirs();
    f.createNewFile();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

//Funciones bombas
void llenar(int puerto)
{
  println("RUN:Llenando!");
  ardu.digitalWrite(puerto, Arduino.HIGH);
  delay(3000);
  ardu.digitalWrite(puerto, Arduino.LOW);
  println("RUN:Hecho!");
}

void alimentar(int puerto,int volumen)
{
  println("RUN: feed");
  int cycles=4;
  while(cycles>=0){
    ardu.digitalWrite(puerto, Arduino.HIGH);
    delay(pulsoBomba);
    ardu.digitalWrite(puerto, Arduino.LOW);
    delay(pulsoApBomba);
    cycles--;
  }
}

void llenarI(){
  llenar(bombaI);
}

void llenarD(){
  llenar(bombaD);
}

//funciones archivo
void abrirCarpeta() {
  println("Opening folder:"+dataPath(""));
  if (System.getProperty("os.name").toLowerCase().contains("windows")) {
    launch("explorer.exe"+" "+dataPath(""));
  } else {
    launch(dataPath(""));
  }
}

void escribirParametros(String flname)
{
  println("FILE:"+flname);
  String datetime = new String(day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  println(datetime);
  String params = new String();
  println(params);
  agregarTextoArchivo(flname, "started: "+datetime);
  agregarTextoArchivo(flname, params);
}

void escribirCabecera(String flname)
{
  agregarTextoArchivo(flname, "");
}

void escribirSeparador(String flname)
{
  agregarTextoArchivo(flname, "");
}

void abrirPuerta(){
  ardu.pinMode(puerta,Arduino.SERVO);
  for(int i = angAbierto;i<angCierre;i++){
    ardu.servoWrite(puerta,i);
    delay(esperaPuerta);
  }
}

void cerrarPuerta(){
  
  for(int i = angCierre;i>angAbierto;i--)
  {
    ardu.servoWrite(puerta,i;
    delay(esperaPuerta);
  }
}

void infoVentana(){
  surface.setTitle("");
}
