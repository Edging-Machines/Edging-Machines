#define edgePin 2
#define pressurePin A0
#define msDiff 10
int lastUpdate = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Hello world");
}

void loop() {
  // put your main code here, to run repeatedly:
  if (millis() - msDiff > lastUpdate)
  {
    Serial.print(millis());
    Serial.print(",");
    Serial.print(analogRead(pressurePin));
    Serial.print(",");
    Serial.print(digitalRead(edgePin));
    Serial.print("\n");
  }
}
