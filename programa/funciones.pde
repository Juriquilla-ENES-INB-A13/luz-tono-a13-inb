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
void alimentar(int puerto, int volumen){
  println("Alimentar:"+puerto);
  int veces = volumen/3;
  for(int i =0;i<veces;i++){
    duino.digitalWrite(puerto,Arduino.HIGH);
    delay(5);
    duino.digitalWrite(puerto,Arduino.LOW);
  }
}

void llenar(int puerto){
  duino.digitalWrite(puerto,Arduino.HIGH);
  delay(2000);
  duino.digitalWrite(puerto,Arduino.LOW);
}

void conectar(){
  println(lstPuertos.getSelectedIndex());
  duino = new Arduino(this,Arduino.list()[lstPuertos.getSelectedIndex()],57600);
  btnAbrirPuerto.setVisible(false);
  btnDesconectar.setVisible(true);
  duino.pinMode(puerta,Arduino.SERVO);
  duino.pinMode(bombaI,Arduino.OUTPUT);
  duino.pinMode(bombaD,Arduino.OUTPUT);
  duino.pinMode(buzzer,Arduino.OUTPUT);
  duino.pinMode(luzEstimulo,Arduino.OUTPUT);
  duino.pinMode(ledEstimulo,Arduino.OUTPUT);
  duino.pinMode(ledBuzzer,Arduino.OUTPUT);
  duino.pinMode(ledOk,Arduino.OUTPUT);
  duino.digitalWrite(ledOk,Arduino.HIGH);
  delay(500);
  duino.digitalWrite(ledOk,Arduino.LOW);
  duino.servoWrite(puerta,30);
  delay(500);
  duino.servoWrite(puerta,64);

}
void desconectar(){
  println("Desconectandor puerto");
  duino.dispose();
  btnDesconectar.setVisible(false);
  btnAbrirPuerto.setVisible(true);
}

void abrirPuerta(){
  duino.servoWrite(puerta,aperturaPuerta);
  println("Abrir puerta");
}
void cerrarPuerta(){
  duino.servoWrite(puerta,cierrePuerta);
  println("Cerrar Puerta");
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

void abrirCarpeta(){
  println("Ariendo carpeta:"+dataPath(""));
  if(System.getProperty("os.name").toLowerCase().contains("windows")){
    launch("explorer.exe"+" "+dataPath(""));
  }else{
    launch(dataPath(""));
  }
}
