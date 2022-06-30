String pruebaLuz(){
  if(esperandoPrueba){
    println("Ya hay otra prueba en ejecución");
    return "";
  }
  println("Estimulo luz");
  esperandoPrueba=true;

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
  int tiempoInicio=millis();
  int tiempoEmpleado=0;
  delay(1000);
  esperandoPrueba=true;
  boolean tocado=false;
  while(esperandoPrueba && (!cancelado)){
    lblEstado.setText("Esperando prueba");
    if((duino.analogRead(sensorI)>minimoSensor)&&(!tocado)){
      println("Luz, exito");
      estado = "exito";
      tocado = true;
      pokeL++;
      alimentar(bombaI,fldVolumenIzquierdo.getValueI());
      tiempoEmpleado=millis()-tiempoInicio;
    }
    if((duino.analogRead(sensorD)>minimoSensor)&&(!tocado)){
      println("Luz, fallo");
      estado = "fallo";
      tocado = true;
      errorL++;
      tiempoEmpleado=millis()-tiempoInicio;
    }
    if((duino.analogRead(sensorE)>minimoSensor)&&(tocado)){
      esperandoPrueba=false;
      circuitoL++;
    }
  }
  println(estado);
  resultado = new String(",luz,"+tiempoEmpleado+","+estado);
  cerrarPuerta();
  delay(1000);
  esperandoPrueba=false;
  return resultado;
} //<>//

String pruebaBuzzer(){
  if(esperandoPrueba){
    println("Ya hay otra prueba en ejecución");
    return "";
  }
  println("Estimulo buzzer");
  esperandoPrueba=true;
  String estado=null;
  String resultado;
  lblEstado.setText("Estímulo Buzzer");
  duino.digitalWrite(buzzer,Arduino.HIGH);
  duino.digitalWrite(ledBuzzer,Arduino.HIGH);
  delay(fldDuracionEstimulo.getValueI());
  duino.digitalWrite(buzzer,Arduino.LOW);
  duino.digitalWrite(ledBuzzer,Arduino.LOW);
  delay(fldRetardoPuerta.getValueI());
  abrirPuerta();
  int tiempoInicio=millis();
  int tiempoEmpleado=0;
  delay(1000);
  esperandoPrueba=true;
  boolean tocado=false;
  while(esperandoPrueba && (!cancelado)){
    lblEstado.setText("Esperando prueba");
    if((duino.analogRead(sensorD)>minimoSensor)&&(!tocado)){
      println("Tono, exito");
      estado = "exito";
      tocado = true;
      pokeT++;
      tiempoEmpleado=millis()-tiempoInicio;
      alimentar(bombaD,fldVolumenDerecho.getValueI());
    }
    if(duino.analogRead(sensorI)>minimoSensor){
      println("Tono,fallo");
      estado = "fallo";
      tocado = true;
      errorT++;
      tiempoEmpleado=millis()-tiempoInicio;
    }
    if((duino.analogRead(sensorE)>minimoSensor)&&(tocado)){
      esperandoPrueba=false;
      circuitoT++;
    }
  }
  println(estado);
  
  resultado = new String(",buzzer,"+tiempoEmpleado+","+estado);
  cerrarPuerta();
  delay(1000);
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
    numLuz--;
    for(;indice<listaTemporal.length;indice++){
      println(numLuz + ","+numTono);
      if(int(random(0,2))==0){
        if(numLuz>0){
          listaTemporal[indice]='l';
          numLuz--;
        }else{
          listaTemporal[indice]='t';
          numTono--;
        }
      }else{
        if(numTono>0){
          listaTemporal[indice]='t';
          numTono--;
        }else{
          listaTemporal[indice]='l';
          numLuz--;
        }
      }
    }
  }else if(chkAleatorio.isSelected()&&(lstEstimulo.getSelectedIndex()==1)){
    listaTemporal[0]='t';
    indice=1;
    numTono--;
    for(;indice<listaTemporal.length;indice++){
      println(numLuz + ","+numTono);
      if(int(random(0,2))==0){
        if(numLuz>0){
          listaTemporal[indice]='l';
          numLuz--;
        }else{
          listaTemporal[indice]='t';
          numTono--;
        }
      }else{
        if(numTono>0){
          listaTemporal[indice]='t';
          numTono--;
        }else{
          listaTemporal[indice]='l';
          numLuz--;
        }
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
  listaTemp=txtaListView.getText();
  errorT = 0;
  errorL =0;
  pokeL=0;
  pokeT=0;
  circuitoL=0;
  circuitoT=0;
  experimentoCorriendo=true;
  char listaExperimentos[] = listaTemp.toCharArray();
  println("num_exp:"+listaExperimentos.length);
  cancelado=false;
  nomArchivo = fldID.getText() + day()+"-"+month()+"-"+year()+"_"+hour()+"-"+minute()+".txt";
  agregarTextoArchivo(nomArchivo,"notas:"+txaNotas.getText());
  //while(experimentoCorriendo){ //<>//
    for(int j=0;j<listaExperimentos.length;j++){ //<>//
      if(cancelado){
        agregarTextoArchivo(nomArchivo,"pokeL:"+pokeL+" pokeT:"+pokeT+" circuitoL:"+circuitoL+" circuitoT:"+circuitoT+" errorL:"+errorL+" errorT:"+errorT);
    experimentoCorriendo=false;
        return;
      }
      println("iter:"+j);
      delay(fldTiempoEspera.getValueI());
      String resultado;
      if(listaExperimentos[j]=='l'){
        
        //agregarTextoArchivo(nomArchivo,j+","+pruebaLuz());
        resultado=pruebaLuz();
      }else{
        resultado=pruebaBuzzer();
        //agregarTextoArchivo(nomArchivo,j+","+pruebaBuzzer());
      }
      agregarTextoArchivo(nomArchivo,resultado);
      
    }
  //}
  agregarTextoArchivo(nomArchivo,"pokeL:"+pokeL+" pokeT:"+pokeT+" circuitoL:"+circuitoL+" circuitoT:"+circuitoT+" errorL:"+errorL+" errorT:"+errorT);
  experimentoCorriendo=false;
  println("terminado");
}
