import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;
import g4p_controls.*;


String fecha;
String hora;
String id;
Arduino ardu;


//conexiones
int ledBuzser=2;
int ledLuz=4;
int motorI=5;
int motorD=6;
int puerta=7;
int sensorI=17;
int sensorD=16;
int sensorE=15;

//variables
int angCierre = 45;
int angAbierto= 100;
int pulsoBomba = 7;



public void setup(){
  size(600, 400, JAVA2D);
  createGUI();
  customGUI();
  
  thread("fecha");
  thread("hora");
  thread("actualizarFechaHora");

  
}

public void draw(){
  background(230);
  
}


public void customGUI(){
  btnDesconectar.setVisible(false);
  fldVolumenIzquierdo.setNumericType(G4P.DECIMAL);
  fldVolumenDerecho.setNumericType(G4P.DECIMAL);
  fldEnsayosLuz.setNumericType(G4P.INTEGER);
  fldEnsayosLuz.setNumericType(G4P.INTEGER);

}
