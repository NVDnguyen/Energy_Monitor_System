
#define PHONE_NUMBER "0123456789"

SoftwareSerial sim800(D7, D8); // RX, TX (D7 là GPIO13, D8 là GPIO15)

void initSIM() {

}

void sendATCommand(String command) {
    sim800.println(command);
    delay(1000); // Đợi module trả lời
    while (sim800.available()) {
        String response = sim800.readString();
        Serial.println("SIM800: " + response);
    }
}

void makeCall(String phoneNumber) {
    sendATCommand("ATD" + phoneNumber + ";");
}

void sendSMS(String phoneNumber, String message) {
    sendATCommand("AT+CMGF=1");
    delay(100);
    sim800.print("AT+CMGS=\"");
        delay(100);

    sim800.print(phoneNumber);
        delay(100);

    sim800.println("\"");
    delay(100);
    sim800.print(message);
    delay(100);
    sim800.write(26); // Ký tự kết thúc tin nhắn (Ctrl+Z)
        delay(300);

}

void handleSerialInput(String input) {
    input.trim(); 
    if (input == "123") {
        makeCall(PHONE_NUMBER); 
    } else if (input == "345") {
        sendSMS(PHONE_NUMBER, "Hello my friend"); 
        sim800.println(input); 
    }
}
