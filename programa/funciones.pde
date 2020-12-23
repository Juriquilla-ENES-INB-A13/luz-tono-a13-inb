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

//common functions

void conectar(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino conectado");
  }
  println("INFO:conectando al puerto:"+Serial.list()[lst_port.getSelectedIndex()]);
  ardu = new Arduino(this, Arduino.list()[lst_port.getSelectedIndex()], 57600);
  ardu.pinMode(motorI, Arduino.OUTPUT);
  ardu.pinMode(motorD, Arduino.OUTPUT);
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
    ardu.digitalWrite(pump, Arduino.HIGH);
    delay(pulsoBomba);
    ardu.digitalWrite(pump, Arduino.LOW);
    delay(pulsoApBomba);
    cycles--;
  }
}

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
  String params = new String("freq:" + fld_freq.getValueI()+" time:"+fld_vibr_duration.getValueF()+" response_time:"+fld_response_time.getValueF()+" repeats:"+fld_repeats.getValueI()+" exp_time:"+fld_time_experiments.getValueF());
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}

void escribirCabecera(String flname)
{
  appendTextToFile(flname, "repeat,ellapsed_time,pokeL,pokeR");
}

void escribirSeparador(String flname)
{
  appendTextToFile(flname, "");
}

void abrirPuerta(){
  ardu.pinMode(door,Arduino.SERVO);
  for(int i = openAngle;i>closeAngle;i--){
    ardu.servoWrite(door,i);
    delay(doorDelay);
  }
}

void cerrarPuerta(){
  ardu.servoWrite(door,openAngle);
}

void addWindowInfo(){
  surface.setTitle("Stage 1 "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+numIteration+ " OK:"+numOk+" Fail:"+numFail);
}
