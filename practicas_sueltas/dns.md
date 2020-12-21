# Servidor DNSmasq

Tarea 1 (1 punto): Modifica los clientes para que utilicen el nuevo servidor dns. Realiza una consulta a www.iesgn.org, y a www.josedomingo.org. Realiza una prueba de funcionamiento para comprobar que el servidor dnsmasq funciona como cache dns. Muestra el fichero hosts del cliente para demostrar que no estás utilizando resolución estática. Realiza una consulta directa al servidor dnsmasq. ¿Se puede realizar resolución inversa?. Documenta la tarea en redmine.

____________________________________________________________


* Instalamos el servidor dns

<pre>apt install dnsmasq</pre>

* Configuramos el nombre de nuestro servidor en el fichero /etc/hosts, añadiendo lo siguiente:

<pre>
127.0.1.1 celia.iesgn.org servidor-nginx
</pre>

* Configuramos es servidor:

Le indicamos la interfaz por la que va servir los nombres.

<pre>
strict-order

interface=eth0
listen-address=10.0.0.5
listen-address=127.0.0.1
</pre>

* Reiniciamos el servicio

<pre>
systemctl retart dnsmasq
</pre>

* Configuramos el cliente, editando el fichero /etc/resolv.conf

<pre>
nameserver 10.0.0.5
</pre>

* Consulta 1:

<pre>
root@cliente-nginx:/home/debian# dig www.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> www.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27932
;; flags: qr aa rd ra ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.iesgn.org.			IN	A

;; ANSWER SECTION:
www.iesgn.org.		0	IN	A	10.0.0.5

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 04 08:15:36 UTC 2020
;; MSG SIZE  rcvd: 58
</pre>


* Consulta 2:

<pre>
root@cliente-nginx:/home/debian# dig www.josedomingo.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> www.josedomingo.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63938
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 5, ADDITIONAL: 6

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 417e2238b5f98010e4e248b05fc9f03445d912072bf39f38 (good)
;; QUESTION SECTION:
;www.josedomingo.org.		IN	A

;; ANSWER SECTION:
www.josedomingo.org.	900	IN	CNAME	playerone.josedomingo.org.
playerone.josedomingo.org. 900	IN	A	137.74.161.90

;; AUTHORITY SECTION:
josedomingo.org.	36684	IN	NS	ns3.cdmon.net.
josedomingo.org.	36684	IN	NS	ns5.cdmondns-01.com.
josedomingo.org.	36684	IN	NS	ns2.cdmon.net.
josedomingo.org.	36684	IN	NS	ns4.cdmondns-01.org.
josedomingo.org.	36684	IN	NS	ns1.cdmon.net.

;; ADDITIONAL SECTION:
ns1.cdmon.net.		18476	IN	A	35.189.106.232
ns2.cdmon.net.		18476	IN	A	35.195.57.29
ns3.cdmon.net.		18476	IN	A	35.157.47.125
ns4.cdmondns-01.org.	36684	IN	A	52.58.66.183
ns5.cdmondns-01.com.	18476	IN	A	52.59.146.62

;; Query time: 227 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 04 08:15:48 UTC 2020
;; MSG SIZE  rcvd: 322
</pre>

* Consulta directa al servidor dns

<pre>
root@cliente-nginx:/home/debian# dig 10.0.0.5

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> 10.0.0.5
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 25733
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: d881e60188d841f656200fb95fc9f111238c325af742a32a (good)
;; QUESTION SECTION:
;10.0.0.5.			IN	A

;; AUTHORITY SECTION:
.			10800	IN	SOA	a.root-servers.net. nstld.verisign-grs.com. 2020120400 1800 900 604800 86400

;; Query time: 1283 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 04 08:19:29 UTC 2020
;; MSG SIZE  rcvd: 140
</pre>

* Consulta inversa:

<pre>
root@cliente-nginx:/home/debian# dig -x 10.0.0.5

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> -x 10.0.0.5
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 15773
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;5.0.0.10.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
5.0.0.10.in-addr.arpa.	0	IN	PTR	www.iesgn.org.

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 04 08:44:06 UTC 2020
;; MSG SIZE  rcvd: 77
</pre>
___________________________________________________________________________________

# Servidor bind9

* Desinstalamos el servidor dnsmasq

<pre>apt remove dnsmasq</pre>

* Vamos a suponer que tenemos un servidor para recibir los correos que se llame correo.iesgn.org y que está en la dirección x.x.x.200 (esto es ficticio).

* Vamos a suponer que tenemos un servidor ftp que se llame ftp.iesgn.org y que está en x.x.x.201 (esto es ficticio)

* Además queremos nombrar a los clientes.

* También hay que nombrar a los virtual hosts de apache: www.iesgn.org y departementos.iesgn.org

* Se tienen que configurar la zona de resolución inversa

Tarea 2 (1 puntos): Realiza la instalación y configuración del servidor bind9 con las características anteriomente señaladas. Entrega las zonas que has definido. Muestra al profesor su funcionamiento.

_____________________________________________________________________________________

* Instalamos el servidor bind9

<pre>
apt install bind9
</pre>

* Configuración del fichero /etc/hosts del servidor

<pre>
127.0.1.1 celia.iesgn.org servidor-nginx
127.0.0.1 localhost
10.0.0.5 www.iesgn.org
10.0.0.5 departamentos.iesgn.org
</pre>

* Vamos a configurar el dns, para ello copiamos el fichero 'vacio' y creamos el nuevo para nuestra configuración.

<pre>
cp /etc/bind/db.empty /var/cache/bind/db.iesgn
</pre>

Lo configuramos de esta forma:

<pre>
; BIND reverse data file for empty rfc1918 zone
;
; DO NOT EDIT THIS FILE - it is used for multiple zones.
; Instead, copy it, edit named.conf, and use that copy.
;
$TTL    86400
@       IN      SOA     celia.iesgn.org. root.iesgn.org. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      celia.iesgn.org.
@       IN      MX      10 correo.iesgn.org.
$ORIGIN iesgn.org.
celia   IN      A       10.0.0.5
correo  IN      A       10.0.0.200
ftp     IN      A       10.0.0.201
cliente IN      A       10.0.0.6
www     IN      CNAME   celia
departamentos   IN      CNAME   celia

</pre>

* Comprobamos que está bien la sintaxis

<pre>
root@servidor-nginx:/home/debian# named-checkzone iesgn.org /var/cache/bind/db.iesgn 
zone iesgn.org/IN: loaded serial 1
OK
</pre>

* Configuramos la zona inversa

<pre>
;
; BIND reverse data file for local loopback interface
;
$TTL    604800
@       IN      SOA     celia.iesgn.org. root.iesgn.org. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS   celia.iesgn.org.
$ORIGIN 0.0.10.in-addr.arpa.
5   IN      PTR     celia.iesgn.org.
6   IN      PTR     cliente
200 IN      PTR     correo.iesgn.org.
201 IN      PTR     ftp


</pre>

* Comprobamos que esta correcto

<pre>root@servidor-nginx:/home/debian# named-checkzone 0.0.10.in-addr.arpa /var/cache/bind/db.rev.iesgn 
zone 0.0.10.in-addr.arpa/IN: loaded serial 1
OK
</pre>


* Configuramos las zonas

<pre>
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

Zone "iesgn.org" {
                        type master;
                        file "/var/cache/bind/db.iesgn";
                        notify yes;
                 };

Zone "0.0.10.in-addr.arpa" {
                        type master;
                        file "/var/cache/bind/db.rev.iesgn";
                        notify yes;
                  };

</pre>


_________________


_______________________________________________

Tarea 3 (1 puntos): Realiza las consultas dig/nslookup desde los clientes preguntando por los siguientes:

* Dirección de pandora.iesgn.org, www.iesgn.org, ftp.iesgn.org


<pre>
debian@cliente-nginx:~$ dig ns iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> ns iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18136
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 6387cfe82e1e45a73d217f515fdc70813937fc62bfc2952f (good)
;; QUESTION SECTION:
;iesgn.org.			IN	NS

;; ANSWER SECTION:
iesgn.org.		86400	IN	NS	afrodita.iesgn.org.
iesgn.org.		86400	IN	NS	celia.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5
afrodita.iesgn.org.	86400	IN	A	10.0.0.8

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 18 09:04:01 UTC 2020
;; MSG SIZE  rcvd: 141

</pre>

<pre>

debian@cliente-nginx:~$ dig mx iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> mx iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 1762
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 4

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 521aa8fc1a9f3c669c04c0bd5fdc70b6e5d99a8e391e24c3 (good)
;; QUESTION SECTION:
;iesgn.org.			IN	MX

;; ANSWER SECTION:
iesgn.org.		86400	IN	MX	10 correo.iesgn.org.

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.
iesgn.org.		86400	IN	NS	afrodita.iesgn.org.

;; ADDITIONAL SECTION:
correo.iesgn.org.	86400	IN	A	10.0.0.200
celia.iesgn.org.	86400	IN	A	10.0.0.5
afrodita.iesgn.org.	86400	IN	A	10.0.0.8

;; Query time: 3 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 18 09:04:54 UTC 2020
;; MSG SIZE  rcvd: 180
</pre>

**www.iesgn.org**

<pre>
root@cliente-nginx:/home/debian# dig www.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> www.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 56947
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 7e06366ba67a3f512f6b9d465fda091fab565540c1a8af86 (good)
;; QUESTION SECTION:
;www.iesgn.org.			IN	A

;; ANSWER SECTION:
www.iesgn.org.		86400	IN	CNAME	celia.iesgn.org.
celia.iesgn.org.	86400	IN	A	10.0.0.5

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 13:18:23 UTC 2020
;; MSG SIZE  rcvd: 120
</pre>



**ftp.iesgn.org**

<pre>
root@cliente-nginx:/home/debian# dig ftp.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> ftp.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7051
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: b2ec7ad0a7db0b8faccc7fd05fda09295602c1108cb6549a (good)
;; QUESTION SECTION:
;ftp.iesgn.org.			IN	A

;; ANSWER SECTION:
ftp.iesgn.org.		86400	IN	A	10.0.0.201

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 13:18:33 UTC 2020
;; MSG SIZE  rcvd: 122
</pre>


* El servidor DNS con autoridad sobre la zona del dominio iesgn.org

<pre>
root@cliente-nginx:/home/debian# dig ns iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> ns iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 43853
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 07b8b645ef38a123303f58125fda0a7695291e60e9ba70bb (good)
;; QUESTION SECTION:
;iesgn.org.			IN	NS

;; ANSWER SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5

;; Query time: 3 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 13:24:06 UTC 2020
;; MSG SIZE  rcvd: 102
</pre>


* El servidor de correo configurado para iesgn.org

<pre>root@cliente-nginx:/home/debian# dig correo.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> correo.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 52764
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: cc7e0a54cf36860acb4df9005fda0a0cdc3952736961a7b0 (good)
;; QUESTION SECTION:
;correo.iesgn.org.		IN	A

;; ANSWER SECTION:
correo.iesgn.org.	86400	IN	A	10.0.0.200

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 13:22:20 UTC 2020
;; MSG SIZE  rcvd: 125
</pre>

* La dirección IP de www.josedomingo.org

<pre>root@cliente-nginx:/home/debian# dig www.josedomingo.org.

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> www.josedomingo.org.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 40666
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 5, ADDITIONAL: 6

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 5a922ac176c0965ab98f87de5fda0bb3a5cc975a4a34a793 (good)
;; QUESTION SECTION:
;www.josedomingo.org.		IN	A

;; ANSWER SECTION:
www.josedomingo.org.	522	IN	CNAME	endor.josedomingo.org.
endor.josedomingo.org.	522	IN	A	37.187.119.60

;; AUTHORITY SECTION:
josedomingo.org.	86020	IN	NS	ns2.cdmon.net.
josedomingo.org.	86020	IN	NS	ns4.cdmondns-01.org.
josedomingo.org.	86020	IN	NS	ns1.cdmon.net.
josedomingo.org.	86020	IN	NS	ns3.cdmon.net.
josedomingo.org.	86020	IN	NS	ns5.cdmondns-01.com.

;; ADDITIONAL SECTION:
ns1.cdmon.net.		172421	IN	A	35.189.106.232
ns2.cdmon.net.		172421	IN	A	35.195.57.29
ns3.cdmon.net.		172421	IN	A	35.157.47.125
ns4.cdmondns-01.org.	86020	IN	A	52.58.66.183
ns5.cdmondns-01.com.	172421	IN	A	52.59.146.62

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 13:29:23 UTC 2020
;; MSG SIZE  rcvd: 318
</pre>

* Una resolución inversa

<pre>
root@cliente-nginx:/home/debian# dig -x 10.0.0.5

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> -x 10.0.0.5
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 214
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: b56590c3d603172852f00ac35fda0c51c0ef22e92930e10e (good)
;; QUESTION SECTION:
;5.0.0.10.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
5.0.0.10.in-addr.arpa.	604800	IN	PTR	celia.iesgn.org.

;; AUTHORITY SECTION:
0.0.10.in-addr.arpa.	604800	IN	NS	celia.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5

;; Query time: 2 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 13:32:01 UTC 2020
;; MSG SIZE  rcvd: 137

</pre>

_______________________________________________________________________________________

# Servidor DNS esclavo

El servidor DNS actual funciona como DNS maestro. Vamos a instalar un nuevo servidor DNS que va a estar configurado como DNS esclavo del anterior, donde se van a ir copiando periódicamente las zonas del DNS maestro. Suponemos que el nombre del servidor DNS esclavo se va llamar afrodita.iesgn.org.

* Creamos una instancia nueva a la que llamaremos afrodita.iesgn.org

<pre>
root@afrodita:/home/debian# hostname -f
afrodita.iesgn.org
</pre>

* Instalamos bind9 en afrodita

<pre>
apt-get install bind9
</pre>
____________________________________________________________________________________

**Tarea 4**

* Entrega la configuración de las zonas del maestro y del esclavo.

**MAESTRO**

<pre>
$TTL    86400
@       IN      SOA     celia.iesgn.org. root.iesgn.org. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      celia.iesgn.org.
@       IN      NS      afrodita.iesgn.org.
@       IN      MX      10 correo.iesgn.org.
$ORIGIN iesgn.org.
celia   IN      A       10.0.0.5
afrodita IN     A       10.0.0.8
correo  IN      A       10.0.0.200
ftp     IN      A       10.0.0.201
cliente IN      A       10.0.0.6
www     IN      CNAME   celia
departamentos   IN      CNAME   celia

</pre>

**ESCLAVO**

<pre>
;
; BIND reverse data file for local loopback interface
;
$TTL    604800
@       IN      SOA     celia.iesgn.org. root.iesgn.org. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS   celia.iesgn.org.
@       IN      NS   afrodita.iesgn.org.
$ORIGIN 0.0.10.in-addr.arpa.
5   IN      PTR     celia.iesgn.org.
8   IN      PTR     afrodita.iesgn.org
6   IN      PTR     cliente
200 IN      PTR     correo.iesgn.org.
201 IN      PTR     ftp

</pre>

* Comprueba si las zonas definidas en el maestro tienen algún error con el comando adecuado.

<pre>
root@servidor-nginx:/home/debian# named-checkzone iesgn.org /var/cache/bind/db.iesgn 
zone iesgn.org/IN: loaded serial 1
OK
</pre>

<pre>
root@servidor-nginx:/home/debian# named-checkzone 0.0.10.in-addr.arpa /var/cache/bind/db.rev.iesgn 
zone 0.0.10.in-addr.arpa/IN: loaded serial 1
OK
</pre>

* Comprueba si la configuración de named.conf tiene algún error con el comando adecuado

<pre>
root@servidor-nginx:/home/debian# named-checkconf
root@servidor-nginx:/home/debian# 

root@afrodita:/home/debian# named-checkconf
root@afrodita:/home/debian# 
</pre>

* Reinicia los servidores y comprueba en los logs si hay algún error. No olvides incrementar el número de serie en el registro SOA si has modificado la zona en el maestro.

<pre>
root@servidor-nginx:/home/debian# /etc/init.d/bind9 restart
[ ok ] Restarting bind9 (via systemctl): bind9.service.
</pre>

<pre>
root@afrodita:/home/debian# /etc/init.d/bind9 restart
[ ok ] Restarting bind9 (via systemctl): bind9.service.
</pre>

Miramos los logs por si hay algun error

<pre>
root@servidor-nginx:/home/debian# cat /var/log/syslog
</pre>


* Muestra la salida del log donde se demuestra que se ha realizado la transferencia de zona.

<pre>
Dec 16 18:10:26 celia named[22718]: client @0x7fd19c4b44a0 10.0.0.8#57585 (iesgn.org): transfer of 'iesgn.org/IN': AXFR started (serial 1)
Dec 16 18:10:26 celia named[22718]: client @0x7fd19c4b44a0 10.0.0.8#57585 (iesgn.org): transfer of 'iesgn.org/IN': AXFR ended
</pre>
_____________________________________________________________________________________

**Tarea 5**

* Configura un cliente para que utilice los dos servidores como servidores DNS.

Añadimos la ip de los dos servidores en el resolv.conf

<pre>
nameserver 10.0.0.5
nameserver 10.0.0.8
</pre>

* Realiza una consulta con dig tanto al maestro como al esclavo para comprobar que las respuestas son autorizadas. ¿En qué te tienes que fijar?

Nos fijamos en que las respuestas son autorizadas (bit AA) y coinciden los números de serie.

**MAESTRO**

<pre>
debian@cliente-nginx:~$ dig +norec @10.0.0.5 iesgn.org. soa

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> +norec @10.0.0.5 iesgn.org. soa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 36967
;; flags: qr aa; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 7cc500d5ede9ed69aa8c191e5fda567ee10f86d71c1abbd1 (good)
;; QUESTION SECTION:
;iesgn.org.			IN	SOA

;; ANSWER SECTION:
iesgn.org.		86400	IN	SOA	celia.iesgn.org. root.iesgn.org. 1 604800 86400 2419200 86400

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.
iesgn.org.		86400	IN	NS	afrodita.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5
afrodita.iesgn.org.	86400	IN	A	10.0.0.8

;; Query time: 3 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 18:48:30 UTC 2020
;; MSG SIZE  rcvd: 182

</pre>


**ESCLAVO**

<pre>
debian@cliente-nginx:~$ dig +norec @10.0.0.8 iesgn.org. soa

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> +norec @10.0.0.8 iesgn.org. soa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 53587
;; flags: qr aa ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 6db5c8b018c505c1110f76345fda56c3a44925ee5da3b3b6 (good)
;; QUESTION SECTION:
;iesgn.org.			IN	SOA

;; ANSWER SECTION:
iesgn.org.		86400	IN	SOA	celia.iesgn.org. root.iesgn.org. 1 604800 86400 2419200 86400

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.
iesgn.org.		86400	IN	NS	afrodita.iesgn.org.

;; ADDITIONAL SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5
afrodita.iesgn.org.	86400	IN	A	10.0.0.8

;; Query time: 2 msec
;; SERVER: 10.0.0.8#53(10.0.0.8)
;; WHEN: Wed Dec 16 18:49:39 UTC 2020
;; MSG SIZE  rcvd: 182

</pre>

* Solicita una copia completa de la zona desde el cliente ¿qué tiene que ocurrir?. Solicita una copia completa desde el esclavo ¿qué tiene que ocurrir?


**CLIENTE**
En el cliente no nos va a dejar porque no estamos autorizados

<pre>
debian@cliente-nginx:~$ dig @10.0.0.5 iesgn.org. axfr

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> @10.0.0.5 iesgn.org. axfr
; (1 server found)
;; global options: +cmd
; Transfer failed.
</pre>

<pre>nano /etc/bind/named.conf.options 
</pre>

<pre>
options {
        directory "/var/cache/bind";
        allow-query { 10.0.0.0/24; };
        allow-transfer { none; };
        auth-nxdomain no;    # conform to RFC1035
        };

        acl slaves {
                10.0.0.8;               // afrodita
        };
</pre>


**ESCLAVO**

Sin embargo en el esclavo si nos lo permite porque esta indicado en el fichero named.conf.options


<pre>
debian@afrodita:~$ dig @10.0.0.5 iesgn.org. axfr

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> @10.0.0.5 iesgn.org. axfr
; (1 server found)
;; global options: +cmd
iesgn.org.		86400	IN	SOA	celia.iesgn.org. root.iesgn.org. 1 604800 86400 2419200 86400
iesgn.org.		86400	IN	NS	celia.iesgn.org.
iesgn.org.		86400	IN	NS	afrodita.iesgn.org.
iesgn.org.		86400	IN	MX	10 correo.iesgn.org.
afrodita.iesgn.org.	86400	IN	A	10.0.0.8
celia.iesgn.org.	86400	IN	A	10.0.0.5
cliente.iesgn.org.	86400	IN	A	10.0.0.6
correo.iesgn.org.	86400	IN	A	10.0.0.200
departamentos.iesgn.org. 86400	IN	CNAME	celia.iesgn.org.
ftp.iesgn.org.		86400	IN	A	10.0.0.201
www.iesgn.org.		86400	IN	CNAME	celia.iesgn.org.
iesgn.org.		86400	IN	SOA	celia.iesgn.org. root.iesgn.org. 1 604800 86400 2419200 86400
;; Query time: 1 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 18:59:47 UTC 2020
;; XFR size: 12 records (messages 1, bytes 347)

</pre>


_____________________________________________________________________________________

**Tarea 6**

* Realiza una consulta desde el cliente y comprueba que servidor está respondiendo.

<pre>
debian@cliente-nginx:~$ dig celia.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> celia.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18603
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 2
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 68e7e06c886abe03457528305fda7a1fd7be1c1e4c0b14dc (good)
;; QUESTION SECTION:
;celia.iesgn.org.		IN	A

;; ANSWER SECTION:
celia.iesgn.org.	86400	IN	A	10.0.0.5

;; AUTHORITY SECTION:
iesgn.org.		86400	IN	NS	celia.iesgn.org.
iesgn.org.		86400	IN	NS	afrodita.iesgn.org.

;; ADDITIONAL SECTION:
afrodita.iesgn.org.	86400	IN	A	10.0.0.8

;; Query time: 3 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Wed Dec 16 21:20:31 UTC 2020
;; MSG SIZE  rcvd: 141

</pre>

* Posteriormente apaga el servidor maestro y vuelve a realizar una consulta desde el cliente ¿quién responde?

Si apagamos el maestro, responde el esclavo:

<pre>
;; SERVER: 10.0.0.8#53(10.0.0.8)
</pre>

<pre>
debian@cliente-nginx:~$ dig celia.iesgn.org

debian@cliente-nginx:~$ dig www.josedomingo.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> www.josedomingo.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18987
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 5, ADDITIONAL: 6

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: d220dfaa41120a3bb688f01c5fda7f0962ffe0048ee51ce0 (good)
;; QUESTION SECTION:
;www.josedomingo.org.		IN	A

;; ANSWER SECTION:
www.josedomingo.org.	900	IN	CNAME	endor.josedomingo.org.
endor.josedomingo.org.	900	IN	A	37.187.119.60

;; AUTHORITY SECTION:
josedomingo.org.	86398	IN	NS	ns3.cdmon.net.
josedomingo.org.	86398	IN	NS	ns2.cdmon.net.
josedomingo.org.	86398	IN	NS	ns5.cdmondns-01.com.
josedomingo.org.	86398	IN	NS	ns4.cdmondns-01.org.
josedomingo.org.	86398	IN	NS	ns1.cdmon.net.

;; ADDITIONAL SECTION:
ns1.cdmon.net.		172799	IN	A	35.189.106.232
ns2.cdmon.net.		172799	IN	A	35.195.57.29
ns3.cdmon.net.		172799	IN	A	35.157.47.125
ns4.cdmondns-01.org.	86398	IN	A	52.58.66.183
ns5.cdmondns-01.com.	172799	IN	A	52.59.146.62

;; Query time: 1932 msec
;; SERVER: 10.0.0.8#53(10.0.0.8)
;; WHEN: Wed Dec 16 21:41:29 UTC 2020
;; MSG SIZE  rcvd: 318
</pre>

_______________________________________________________________

# Delegación de dominios

Tenemos un servidor DNS que gestiona la zona correspondiente al nombre de dominio iesgn.org, en esta ocasión queremos delegar el subdominio informatica.iesgn.org para que lo gestione otro servidor DNS. Por lo tanto tenemos un escenario con dos servidores DNS:


* pandora.iesgn.org, es servidor DNS autorizado para la zona iesgn.org.

* ns.informatica.iesgn.org, es el servidor DNS para la zona informatica.iesgn.org y, está instalado en otra máquina.

Los nombres que vamos a tener en ese subdominio son los siguientes:

* www.informatica.iesgn.org corresponde a un sitio web que está alojado en el servidor web del departamento de informática.
* Vamos a suponer que tenemos un servidor ftp que se llame ftp.informatica.iesgn.org y que está en la misma máquina.
* Vamos a suponer que tenemos un servidor para recibir los correos que se llame correo.informatica.iesgn.org.

______________________________________________________________________________

Tarea 7 (2 puntos): Realiza la instalación y configuración del nuevo servidor dns con las características anteriormente señaladas. Muestra el resultado al profesor.

* Creamos la máquina en openstack

* Le apropiamos de su nombre completo

<pre>root@ares:/var/www/informatica# hostname -f
ns.informatica.iesgn.org
</pre>

* Configuración del DNS principal que tiene autoridad sobre la zona iesgn.org

<pre>
$TTL    86400
@       IN      SOA     celia.iesgn.org. root.iesgn.org. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL
;
@       IN      NS      celia.iesgn.org.
@       IN      NS      afrodita.iesgn.org.
@       IN      MX      10 correo.iesgn.org.
$ORIGIN iesgn.org.
celia   IN      A       10.0.0.5
afrodita IN     A       10.0.0.8
correo  IN      A       10.0.0.200
ftp     IN      A       10.0.0.201
cliente IN      A       10.0.0.6
www     IN      CNAME   celia
departamentos   IN      CNAME   celia

$ORIGIN informatica.iesgn.org.
@       IN      NS      ns
ns      IN      A       10.0.0.16
</pre>

* Comprobación de que está correcto

<pre>
root@servidor-nginx:/home/debian# named-checkzone iesgn.org /var/cache/bind/db.iesgn 
zone iesgn.org/IN: informatica.iesgn.org/NS 'ns.informatica.iesgn.org' (out of zone) has no addresses records (A or AAAA)
zone iesgn.org/IN: loaded serial 1
OK
</pre>

**SERVIDOR DNS SECUNDARIO: 'ARES'**

* Definir zona del subdominio

<pre>
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

zone "informatica.iesgn.org" {
  type master;
  file "db.informatica.iesgn.org";
};
</pre>

Permitir la recursividad, se la quitamos en el fichero named.conf.options

* Configuración del dns del subdominio (informatica.iesgn.org). Al que le añadimos los demás servicios indicados.

<pre>
$TTL    86400
@       IN      SOA     ns.informatica.iesgn.org. root.iesgn.org. (
                              4
                         604800
                          86400
                        2419200
                          86400 )
$ORIGIN informatica.iesgn.org.
@         IN      NS      ns
ns        IN      A       10.0.0.16
www       IN      A       10.0.0.18
ftp       IN      CNAME   ns
correo    IN      CNAME   ns
</pre>

* Comprobar que está correcto:

<pre>
root@ares:/var/www/informatica# named-checkzone informatica.iesgn.org /var/cache/bind/db.informatica.iesgn.org
zone informatica.iesgn.org/IN: loaded serial 4
OK
</pre>

* Reiniciar los servicios en los dos servidores

<pre>systemctl restart bind9</pre>
____________________________________________________________________________________

Tarea 8 (1 punto): Realiza las consultas dig/neslookup desde los clientes preguntando por los siguientes:

* Dirección de www.informatica.iesgn.org, ftp.informatica.iesgn.org

Podemos comprobar que la respuesta pertenece a nuestro dns principal siendo gestionada por el dns secundario.

**www.informatica.iesgn.org,**

<pre>
debian@cliente-nginx:~$ dig www.informatica.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> www.informatica.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32259
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: d804102e6021dda6118d9e7f5fdc6f7a9b7b3365728dea15 (good)
;; QUESTION SECTION:
;www.informatica.iesgn.org.	IN	A

;; ANSWER SECTION:
www.informatica.iesgn.org. 86400 IN	A	10.0.0.18

;; AUTHORITY SECTION:
informatica.iesgn.org.	86400	IN	NS	ns.informatica.iesgn.org.

;; Query time: 5 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 18 08:59:38 UTC 2020
;; MSG SIZE  rcvd: 115


</pre>

**ftp.informatica.iesgn.org**

<pre>
debian@cliente-nginx:~$ dig ftp.informatica.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> ftp.informatica.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2778
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 8b7301747e8d2091aad3188f5fdc74970452b3bb5dcbb220 (good)
;; QUESTION SECTION:
;ftp.informatica.iesgn.org.	IN	A

;; ANSWER SECTION:
ftp.informatica.iesgn.org. 86400 IN	CNAME	ns.informatica.iesgn.org.
ns.informatica.iesgn.org. 86400	IN	A	10.0.0.16

;; AUTHORITY SECTION:
informatica.iesgn.org.	86400	IN	NS	ns.informatica.iesgn.org.

;; Query time: 6 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 18 09:21:27 UTC 2020
;; MSG SIZE  rcvd: 129

</pre>

* El servidor DNS que tiene configurado la zona del dominio informatica.iesgn.org. ¿Es el mismo que el servidor DNS con autoridad para la zona iesgn.org?

No, son dos servidores dns diferentes solo que se ha delegado el subdominio informatica.

* El servidor de correo configurado para informatica.iesgn.org

<pre>
debian@cliente-nginx:~$ dig correo.informatica.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> correo.informatica.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 56721
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 7bec5c4bd0ff50a3b75faba65fdc751a2fe35f120bd77831 (good)
;; QUESTION SECTION:
;correo.informatica.iesgn.org.	IN	A

;; ANSWER SECTION:
correo.informatica.iesgn.org. 86400 IN	CNAME	ns.informatica.iesgn.org.
ns.informatica.iesgn.org. 86269	IN	A	10.0.0.16

;; AUTHORITY SECTION:
informatica.iesgn.org.	86269	IN	NS	ns.informatica.iesgn.org.

;; Query time: 5 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 18 09:23:38 UTC 2020
;; MSG SIZE  rcvd: 132

</pre>

<pre>
debian@cliente-nginx:~$ dig mx correo.informatica.iesgn.org

; <<>> DiG 9.11.5-P4-5.1+deb10u2-Debian <<>> mx correo.informatica.iesgn.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 39657
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 4cff6d3ed3c0877b6e726b705fdc753d49516b673db01a47 (good)
;; QUESTION SECTION:
;correo.informatica.iesgn.org.	IN	MX

;; ANSWER SECTION:
correo.informatica.iesgn.org. 86365 IN	CNAME	ns.informatica.iesgn.org.

;; AUTHORITY SECTION:
informatica.iesgn.org.	10800	IN	SOA	ns.informatica.iesgn.org. root.iesgn.org. 4 604800 86400 2419200 86400

;; Query time: 3 msec
;; SERVER: 10.0.0.5#53(10.0.0.5)
;; WHEN: Fri Dec 18 09:24:13 UTC 2020
;; MSG SIZE  rcvd: 143

</pre>
