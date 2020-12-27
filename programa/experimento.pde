void pruebaLuz()
{
  if(!esperandoPrueba){
    return;
  }
  int tiempoLimite = millis()+fldTiempoEspera.getValueI();
  int tiempoEmpleado;
  String estado="null";
  String resultado;
  sensorTocadoI=false;
  sensorTocadoD=false;
  esperandoPrueba=true;
  lblEstado.setText("Esímulo LED");
  ardu.digitalWrite(led,Arduino.HIGH);
  delay(fldDuracionEstimulo.getValueI());
  ardu.digitalWrite(led,Arduino.LOW);
  while(esperandoPrueba && (!cancelado)){
    lblEstado.setText("Esperando prueba");
    if(millis()>=tiempoLimite){
      estado = "expirado";
      esperandoPrueba=false;
    }
    if(ardu.analogRead(sensorI)>900){
      estado = "exito";
      esperandoPrueba=false;
      alimentar(bombaI,fldVolumenIzquierdo.getValueI());
    }
    if(ardu.analogRead(sensorD)>900){
      estado = "fallo";
      esperandoPrueba=false;
    }
  }
  agregarTextoArchivo(nomArchivo,iteracion+",luz,"+millis()+","+estado);
}

void pruebaBuzzer()
{
  if(!esperandoPrueba){
    return;
  }
  int tiempoLimite = millis()+fldTiempoEspera.getValueI();
  int tiempoEmpleado;
  String estado="null";
  String resultado;
  sensorTocadoI=false;
  sensorTocadoD=false;
  esperandoPrueba=true;
  lblEstado.setText("Esímulo Buzzer");
  ardu.digitalWrite(buzzer,Arduino.HIGH);
  delay(fldDuracionEstimulo.getValueI());
  ardu.digitalWrite(buzzer,Arduino.LOW);
  while(esperandoPrueba && (!cancelado)){
    lblEstado.setText("Esperando prueba");
    if(millis()>=tiempoLimite){
      estado = "expirado";
      esperandoPrueba=false;
    }
    if(ardu.analogRead(sensorD)>900){
      estado = "exito";
      esperandoPrueba=false;
      alimentar(bombaI,fldVolumenIzquierdo.getValueI());
    }
    if(ardu.analogRead(sensorI)>900){
      estado = "fallo";
      esperandoPrueba=false;
    }
  }
  agregarTextoArchivo(nomArchivo,iteracion+",buzzer,"+millis()+","+estado);
}

void experimento()
{
  if(!experimentoCorriendo){
    return;
  }
  btnIniciar.setVisible(false);
  btnDetener.setVisible(true);
  iteracion=1;
  nomArchivo = fldID.getText() + day()+"-"+month()+"-"+year()+"_"+hour()+minute();
  if(lstEstimulo.getSelectedIndex()==0){
    while(experimentoCorriendo){
      if(((int(random(2)))==0)&&(experimentosLuz>0))
      {
        pruebaLuz();
        experimentosLuz--;
      }else{
        pruebaBuzzer();
        experimentosBuzzer--;
      }
      if((experimentosLuz==0)&&(experimentosBuzzer==0)){
        experimentoCorriendo=false;
      }
      iteracion++;
    }
    if(lstEstimulo.getSelectedIndex()==1{
      pruebaLuz();
      experimentosLuz--;
      while(experimentoCorriendo){
        if(((int(random(2)))==0)&&(experimentosLuz>0))
        {
          pruebaLuz();
          experimentosLuz--;
        }else{
          pruebaBuzzer();
          experimentosBuzzer--;
        }
        if((experimentosLuz==0)&&(experimentosBuzzer==0)){
          experimentoCorriendo=false;
        }
      }
      iteracion++;
    }
    if(lstEstimulo.getSelectedIndex()==2{
      pruebaBuzzer();
      experimentosBuzzer--;
      while(experimentoCorriendo){
        if(((int(random(2)))==0)&&(experimentosLuz>0))
        {
          pruebaLuz();
          experimentosLuz--;
        }else{
          pruebaBuzzer();
          experimentosBuzzer--;
        }
        if((experimentosLuz==0)&&(experimentosBuzzer==0)){
          experimentoCorriendo=false;
        }
      }
      iteracion++;
    }
  }
  btnIniciar.setVisible(true);
  btnDetener.setVisible(false);
}
