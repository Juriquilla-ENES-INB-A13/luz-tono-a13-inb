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
}

void llenar(int puerto){
}

void conectar(){
  println(lstPuertos.getSelectedIndex());
  duino = new Arduino(this,Arduino.list()[lstPuertos.getSelectedIndex()],57600);
  btnAbrirPuerto.setVisible(false);
  btnDesconectar.setVisible(true);
}
void desconectar(){
  println("Desconectandor puerto");
  duino.dispose();
  btnDesconectar.setVisible(false);
  btnAbrirPuerto.setVisible(true);
}
