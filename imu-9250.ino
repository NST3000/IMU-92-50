#include "MPU9250.h"
#include <Wire.h>
MPU9250 mpu;
float yaw,pitch,roll;
void setup() {
    Serial.begin(9600);
    Wire.begin();
    delay(200);

    if (!mpu.setup(0x68)) {  // change to your own address
        while (1) {
            Serial.println("MPU connection failed. Please check your connection with `connection_check` example.");
            delay(500);
        }
    }
}

void loop() {
    if (mpu.update()) {
        static uint32_t prev_ms = millis();
        if (millis() > prev_ms + 25) {
            //print_roll_pitch_yaw();
            yaw= mpu.getYaw()+50;
            roll=-mpu.getRoll();
            pitch=-mpu.getPitch();
            Serial.print("Yaw: ");
            Serial.print(yaw);
            Serial.print("/ ");
            Serial.print("Roll: /");
            Serial.print(pitch);
            Serial.print("/ ");
            Serial.print("Pitch: /");
            Serial.print(roll);
            Serial.println("/ ");
            prev_ms = millis();
        }
    }
}
