String pruebaLuz(){
  if(esperandoPrueba){
    println("Ya hay otra prueba en ejecución");
    return "";
    
  }
  println("Estimulo luz");
  esperandoPrueba=true;
  int tiempoInicio=millis();
  int tiempoLimite = tiempoInicio+1000+fldTiempoEspera.getValueI();
  int tiempoEmpleado;
  String estado=null;
  String resultado;
  lblEstado.setText("Estímulo luz");
  duino.digitalWrite(luzEstimulo,Arduino.HIGH);
  duino.digitalWrite(ledEstimulo,Arduino.HIGH);
  delay(fldDuracionEstimulo.getValueI());
  duino.digitalWrite(luzEstimulo,Arduino.LOW);
  duino.digitalWrite(ledEstimulo,Arduino.LOW);
  delay(fldRetardoPuerta.getValueI());
  abrirPuerta();
  esperandoPrueba=true;
  while(esperandoPrueba && (!cancelado)){
    lblEstado.setText("Esperando prueba");
    if(millis()>=tiempoLimite){
      estado = "expirado";
      esperandoPrueba=false;
    }
    if(duino.analogRead(sensorI)>minimoSensor){
      estado = "exito";
      esperandoPrueba=false;
      alimentar(bombaI,fldVolumenIzquierdo.getValueI());
    }
    if(duino.analogRead(sensorD)>minimoSensor){
      estado = "fallo";
      esperandoPrueba=false;
    }
  }
  println(estado);
  tiempoEmpleado=millis()-tiempoInicio;
  resultado = new String(",luz,"+tiempoEmpleado+","+estado);
  cerrarPuerta();
  esperandoPrueba=false;
  return resultado;
}


String pruebaBuzzer(){
  if(esperandoPrueba){
    println("Ya hay otra prueba en ejecución");
    return "";
    
  }
  println("Estimulo buzzer");
  esperandoPrueba=true;
  int tiempoInicio=millis();
  int tiempoLimite = tiempoInicio+1000+fldTiempoEspera.getValueI();
  int tiempoEmpleado;
  String estado=null;
  String resultado;
  boolean sensorTocado=false;
  lblEstado.setText("Estímulo Buzzer");
  duino.digitalWrite(buzzer,Arduino.HIGH);
  duino.digitalWrite(ledBuzzer,Arduino.HIGH);
  delay(fldDuracionEstimulo.getValueI());
  duino.digitalWrite(buzzer,Arduino.LOW);
  duino.digitalWrite(ledBuzzer,Arduino.LOW);
  delay(fldRetardoPuerta.getValueI());
  abrirPuerta();
  esperandoPrueba=true;
  while(esperandoPrueba && (!cancelado)){
    lblEstado.setText("Esperando prueba");
    if(millis()>=tiempoLimite){
      estado = "expirado";
      esperandoPrueba=false;
    }
    if(duino.analogRead(sensorD)>minimoSensor){
      estado = "exito";
      esperandoPrueba=false;
      alimentar(bombaD,fldVolumenIzquierdo.getValueI());
    }
    if(duino.analogRead(sensorI)>minimoSensor){
      estado = "fallo";
      esperandoPrueba=false;
    }
  }
  println(estado);
  tiempoEmpleado=millis()-tiempoInicio;
  resultado = new String(",buzzer,"+tiempoEmpleado+","+estado);
  cerrarPuerta();
  esperandoPrueba=false;
  return resultado;
}

public char[] crearLista(){
  int numLuz = fldEnsayosLuz.getValueI();
  int numTono = fldEnsayosTono.getValueI();
  int indice =0;
  char listaTemporal[] = new char[fldEnsayosLuz.getValueI()+fldEnsayosTono.getValueI()];
  if(chkAleatorio.isSelected()&&(lstEstimulo.getSelectedIndex()==0))
  {
    listaTemporal[0]='l';
    indice=1;
    for(;indice<listaTemporal.length;indice++){
      if(int(random(0,2))==0){
        listaTemporal[indice]='l';
      }else{
        listaTemporal[indice]='t';
      }
    }
  }else if(chkAleatorio.isSelected()&&(lstEstimulo.getSelectedIndex()==1)){
    listaTemporal[0]='t';
    indice=1;
    for(;indice<listaTemporal.length;indice++){
      if(int(random(0,2))==0){
        listaTemporal[indice]='l';
      }else{
        listaTemporal[indice]='t';
      }
    }
  }else if(!chkAleatorio.isSelected()&&(lstEstimulo.getSelectedIndex()==0)){
    int i=0;
    for(;i<numLuz;i++){
      listaTemporal[i]='l';
    }
    for(;i<listaTemporal.length;i++){
      listaTemporal[i]='t';
    }
  }else if(!chkAleatorio.isSelected()&&(lstEstimulo.getSelectedIndex()==1)){
    int i =0;
    for(;i<numTono;i++){
      listaTemporal[i]='t';
    }
    for(;i<listaTemporal.length;i++){
      listaTemporal[i]='l';
    }

  }
  println(listaTemporal);
  return listaTemporal;
}

void experimento(){ 
  if(experimentoCorriendo){
    println("Ya hay otro experimento corriendo");
    return;
  }
  experimentoCorriendo=true;
  char listaExperimentos[] = crearLista();
  String resultadoExperimento;
  cancelado=false;

  nomArchivo = fldID.getText() + day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+".txt";
  agregarTextoArchivo(nomArchivo,"notas:"+txaNotas.getText());
  while(experimentoCorriendo){
    for(int j=0;j<listaExperimentos.length;j++){
      if(listaExperimentos[j]=='l'){
        agregarTextoArchivo(nomArchivo,j+","+pruebaLuz());
      }else{
        agregarTextoArchivo(nomArchivo,j+","+pruebaBuzzer());
      }
    }
  }
  experimentoCorriendo=false;
  println("terminado");
}
