<h1><b> What is Gammu </b></h1>
Gammu SMSD is a service to mass send and receive SMS messages. Both these are built on top of Gammu library, which provides abstraction layer to work with different cell phones from different vendors (including Nokia, Sony-Ericsson, Motorola, Samsung, Siemens, Huawei and others). And 3G/4G Dongle.
<br><br>
To get started 1 Plug in your 3G/4G Dongle into your Laptop/PC/Server or Raspberry PI. Check if your dongle is found by executing: lsusb
<br><br>
Once you have found create a Docker <a href="https://hub.docker.com/_/mysql">MySQL</a> container and a database
<br><br>
Execute:<br>
<code>docker run --name sms-sender --restart always -i --device=/dev/ttyUSB1 --publish-all -p 802:80 -d valterseu/gammu-sms</code>
<br><br>
The <b>/dev/ttyUSB1</b> Can be different from the above-mentioned example, based on your system and to which USB port you have your device connected.
<br><br>
Once the Docker container is Running change the configuration in the Docker container /etc/gammu-smsdrc<br>

<code><br>
port = /dev/ttyUSB1<br>
connection = AT<br>
speed = 9600<br><br>
How often to reset the device if it is stuck<br>
ResetFrequency = 11<br>
A hard reset, so that 3G Doungle doesn't get stuck<br>
HardResetFrequency = 20<br>
How often to check for incoming TEXT Messages<br>
ReceiveFrequency = 10<br>
How often to check for GSM connection ( Suggested every 30 minutes )<br>
StatusFrequency = 30<br>
How often to check outgoing SMS if there are none stuck? ( Suggested every 15 minutes )<br>
CommTimeout = 5<br>
How long to wait for a mobile carrier to answer if an SMS is sent? By default it is 30 seconds<br>
SendTimeout = 3<br>
If set to 1 then Doungle will go into standby if no activity ( Suggested to put leave as is or set 0 )<br>
LoopSleep = 0<br>
How long does to wait for a large text SMS to be sent Suggested 6 seconds<br>
MultipartTimeout = 6<br>
Reject incoming phone calls to the SIM<br>
HangupCalls = 1<br>
Check if the SIM card wants a pin<br>
CheckSecurity = 1<br>
How many times to retry resending an SMS if something goes wrong?<br>
MaxRetries = 1<br>
After how many seconds to retry sending failed SMS Messages?<br>
RetryTimeout = 5<br><br>
[smsd]<br><br>
MySQL Connection<br>
service = sql<br>
driver = native_mysql<br>
host = MySQL_HOST<br>
user = MySQL_USER<br>
password = MySQL_USER_PASSWORD<br>
database = MySQL_DB_NAME<br>
<br>
SMSD configuration, see gammu-smsdrc(5)<br>
<br>
OutboxFormat = unicode<br>
TransmitFormat = unicode<br>
PIN = 0000<br>
RetryTimeout = 5<br>
MultipartTimeout = 5<br>
ResetFrequency = 30<br>
HardResetFrequency = 60<br>
DeliveryReport = sms<br>
PhoneID = first<br>
logfile = /var/log/sms_log<br>
debuglevel = 255<br>
StatusFrequency = 0<br>
CommTimeout = 7<br>
SendTimeout = 10<br>
HangupCalls = 1<br>
LoopSleep = 0<br>
CheckSecurity = 0<br>
</code><br>
<h3>To send SMS using web post execute</h3><br>
Example: <br><code>http://<127.0.0.1:802/index.php?rec=37122222222&text=Text%20Message</code>
<br>
Or in Docker terminal:<br>
<code> gammu-smsd-inject --config=/etc/gammu-smsdrc TEXT 371222222 -unicode -textutf8 Message</code>
<br>
<h1><b>For additional information and also tutorial visit:</b></h1>

<b><h3>Valters.eu - Blog</h3><b>https://www.valters.eu/how-to-send-sms-using-3g-4g-dongle-and-dockerl
<b><h3>Docker Image</h3><b>https://hub.docker.com/r/valterseu/gammu-sms
<b><h3>Youtube Video How TO Guide</h3><b>https://www.youtube.com/@valters_eu
<b><h3>For more cool stuff follow me on Twitter</h3><b>http://twitter.com/valters_eu
