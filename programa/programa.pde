
import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;
import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;
String fecha;
String hora;
String id;
Arduino duino;

//conexiones
int bombaD=5;
int bombaI=6;
int puerta=8;
int buzzer=4;
int luzEstimulo=7;
int ledEstimulo=3;
int ledBuzzer=2;
int ledOk=10;
int cierrePuerta=64;
int aperturaPuerta=10;
int sensorI=1;
int sensorD=2;
int sensorE=0;
int iteracion;
int minimoSensor=900;

boolean experimentoCorriendo=false;
boolean esperandoPrueba=false;
boolean cancelado=false;

String[] pruebas = {"luz","tono"};
String prueba;
String nomArchivo;

public void setup(){
  size(800, 400, JAVA2D);
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
  fldEnsayosLuz.setNumericType(G4P.INTEGER);
  fldEnsayosTono.setNumericType(G4P.INTEGER);
  fldTiempoEspera.setNumericType(G4P.INTEGER);
  fldVolumenDerecho.setNumericType(G4P.INTEGER);
  fldVolumenIzquierdo.setNumericType(G4P.INTEGER);
  fldDuracionEstimulo.setNumericType(G4P.INTEGER);
  fldRetardoPuerta.setNumericType(G4P.INTEGER);
  fldTiempoEspera.setText("1000");
  fldDuracionEstimulo.setText("500");
  fldRetardoPuerta.setText("1000");
  fldVolumenDerecho.setText("3");
  fldVolumenIzquierdo.setText("3");
  Integer ID = new Integer(int(random(1000000)));
  fldID.setText(ID.toString());
}
