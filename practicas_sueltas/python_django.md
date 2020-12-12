# Tarea 1: Entorno de desarrollo

* Realiza un fork del repositorio de GitHub: https://github.com/josedom24/django_tutorial.

* Crea un entorno virtual de python3 e instala las dependencias necesarias para que funcione el proyecto (fichero requirements.txt).

[Crear entorno virtual](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/https://github.com/CeliaGMqrz/trabajando_python3_venv)

* Comprueba que vamos a trabajar con una base de datos sqlite (django_tutorial/settings.py). ¿Cómo se llama la base de datos que vamos a crear?

Se llama **db.sqlite3**

```powershell
# Database
# https://docs.djangoproject.com/en/3.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

* Crea la base de datos: python3 manage.py migrate. A partir del modelo de datos se crean las tablas de la base de datos.

```powershell
python3 manage.py migrate
```

```powershell
(django) celiagm@debian:~/github/django_tutorial$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, polls, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying polls.0001_initial... OK
  Applying sessions.0001_initial... OK

```
* Crea un usuario administrador: python3 manage.py createsuperuser.

```powershell
python3 manage.py createsuperuser
```

* Ejecuta el servidor web de desarrollo y entra en la zona de administración (\admin) para comprobar que los datos se han añadido correctamente.

```powershell
python manage.py runserver
```
![c1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/c1.png)

![c2.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/c2.png)

* Crea dos preguntas, con posibles respuestas.

Le damos a + 'add' y creamos las respuestas y luego 'Save' para guardarlas.

![q1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/q1.png)

![q2.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/q2.png)

* Comprueba en el navegador que la aplicación está funcionando, accede a la url \polls.


![fun1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/fun1.png)

![fun2.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/fun2.png)

_________________________________________________________________________________

# Tarea 2: Entorno de producción

Vamos a realizar el despliegue de nuestra aplicación en un entorno de producción, para ello vamos a utilizar una instancia del cloud, sigue los siguientes pasos:

* Instala en el servidor los servicios necesarios (apache2). Instala el módulo de apache2 para ejecutar código python.

```powershell
apt install apache2
apt install apt install libapache2-mod-wsgi-py3
apt install mariadb-client mariadb-server
apt install php php-mysql libapache2-mod-php php-gd

```

* Clona el repositorio en el DocumentRoot de tu virtualhost.

Clonamos el repositorio en nuestro documenroot (/var/www/html)

```powershell

Clonamos el repositorio en el documenroot

```powershell
git clone https://github.com/CeliaGMqrz/django_tutorial.git
```

Le damos los permisos adecuados

```powershell
sudo chown -R www-data:www-data django_tutorial
```

Creamos el virtualhost

```powershell
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/django.conf
nano /etc/apache2/sites-available/django.conf

```
**django.conf**
```powershell
<VirtualHost *:80>
        ServerName www.celia.django.iesgn.org
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/django_tutorial
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```


* Crea un entorno virtual e instala las dependencias de tu aplicación

```powershell
apt install python3-venv
python3 -m venv django
```

```powershell
(django) root@django:/var/www/html/django_tutorial# pip install -r requirements.txt 
Collecting asgiref==3.3.0 (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/c0/e8/578887011652048c2d273bf98839a11020891917f3aa638a0bc9ac04d653/asgiref-3.3.0-py3-none-any.whl
Collecting Django==3.1.3 (from -r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/7f/17/16267e782a30ea2ce08a9a452c1db285afb0ff226cfe3753f484d3d65662/Django-3.1.3-py3-none-any.whl (7.8MB)
    100% |████████████████████████████████| 7.8MB 127kB/s 
Collecting pytz==2020.4 (from -r requirements.txt (line 3))
  Downloading https://files.pythonhosted.org/packages/12/f8/ff09af6ff61a3efaad5f61ba5facdf17e7722c4393f7d8a66674d2dbd29f/pytz-2020.4-py2.py3-none-any.whl (509kB)
    100% |████████████████████████████████| 512kB 1.9MB/s 
Collecting sqlparse==0.4.1 (from -r requirements.txt (line 4))
  Downloading https://files.pythonhosted.org/packages/14/05/6e8eb62ca685b10e34051a80d7ea94b7137369d8c0be5c3b9d9b6e3f5dae/sqlparse-0.4.1-py3-none-any.whl (42kB)
    100% |████████████████████████████████| 51kB 2.5MB/s 
Installing collected packages: asgiref, pytz, sqlparse, Django
Successfully installed Django-3.1.3 asgiref-3.3.0 pytz-2020.4 sqlparse-0.4.1
```
Comprobamos que tenemos los paquetes instalados

```powershell
(django) root@django:/var/www/html/django_tutorial# pip freeze
asgiref==3.3.0
Django==3.1.3
pkg-resources==0.0.0
protobuf==3.14.0
pytz==2020.4
six==1.15.0
sqlparse==0.4.1

```


* Instala el módulo que permite que python trabaje con mysql:

```powershell
$ apt-get install python3-mysqldb
```

* Y en el entorno virtual:

```powershell
(env)$ pip install mysql-connector-python
```

* Crea una base de datos y un usuario en mysql.

```powershell
(django) root@django:/var/www/# mysql -u root -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 49
Server version: 10.3.27-MariaDB-0+deb10u1 Debian 10

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> create database django;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> create user 'user'@'%';
Query OK, 0 rows affected (0.001 sec)


MariaDB [(none)]> grant all privileges on django.* to 'user'@'%' identified by 'user';
Query OK, 0 rows affected (0.009 sec)

```

* Configura la aplicación para trabajar con mysql, para ello modifica la configuración de la base de datos en el archivo settings.py:

```powershell
  DATABASES = {
      'default': {
          'ENGINE': 'mysql.connector.django',
          'NAME': 'django',
          'USER': 'user',
          'PASSWORD': 'user',
          'HOST': 'localhost',
          'PORT': '',
      }
  }
```

* Como en la tarea 1, realiza la migración de la base de datos que creará la estructura de datos necesarias. comprueba en mariadb que la base de datos y las tablas se han creado.


```powershell
(django) root@django:/var/www/html/django_tutorial# python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, polls, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying polls.0001_initial... OK
  Applying sessions.0001_initial... OK

```

* Crea un usuario administrador: python3 manage.py createsuperuser.

```powershell
python3 manage.py createsuperuser
```

* Configura un virtualhost en apache2 con la configuración adecuada para que funcione la aplicación. El punto de entrada de nuestro servidor será django_tutorial/django_tutorial/wsgi.py. Puedes guiarte por el Ejercicio: Desplegando aplicaciones flask, por la documentación de django: How to use Django with Apache and mod_wsgi,…


```powershell
<VirtualHost *:80>
        ServerName www.celia.django.iesgn.org
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/django_tutorial
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        DocumentRoot /var/www/html/django_tutorial
        WSGIDaemonProcess django user=www-data group=www-data processes=1 threads=5 python-path=/var/www/html/django_tutorial:/var/www/html/django_tutorial/django/lib/python3.7/site-packages
        WSGIScriptAlias / /var/www/html/django_tutorial/django_tutorial/wsgi.py

        <Directory /var/www/html/django_tutorial/django_tutorial>
                WSGIProcessGroup django
                WSGIApplicationGroup %{GLOBAL}
                Require all granted
        </Directory>
</VirtualHost>

```
Nos sale un error que nos indica que tenemos que permitir al host, para ello añadimos lo siguiente en el fichero settings.py

![error1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/error1.png)

```sh
ALLOWED_HOSTS = ['www.celia.django.iesgn.org']
```

Ahora vemos que podemos ver el sitio web pero no se ha cargado el contenido estático:

![error2.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/error2.png)

Para solucionarlo vamos a configurar dos alias con las rutas del contenido estático, por lo tanto el fichero de configuración quedaría de esta forma:

```sh
<VirtualHost *:80>
        ServerName www.celia.django.iesgn.org
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/django_tutorial
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        DocumentRoot /var/www/html/django_tutorial
        WSGIDaemonProcess django user=www-data group=www-data processes=1 threads=5 python-path=/var/www/html/django_tutorial:/var/www/html/django_tutorial/django/lib/python3.7/site-packages
        WSGIScriptAlias / /var/www/html/django_tutorial/django_tutorial/wsgi.py

        <Directory /var/www/html/django_tutorial/django_tutorial>
                WSGIProcessGroup django
                WSGIApplicationGroup %{GLOBAL}
                Require all granted
        </Directory>

        Alias /static/admin/ /var/www/html/django_tutorial/django/lib/python3.7/site-packages/django/contrib/admin/static/admin/

        <Directory /var/www/html/django_tutorial/django/lib/python3.7/site-packages/django/contrib/admin/static/admin/>
                Require all granted
        </Directory>

        Alias /static/polls/ /var/www/html/django_tutorial/polls/static/

        <Directory /var/www/html/django_tutorial/polls/static>
                Require all granted
        </Directory>
</VirtualHost>
```

Comprobamos que funciona correctamente

![prod1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/prod1.png)

![prod2.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/prod2.png)

![prod3.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/prod3.png)

_____________________________________________________________________________________


# Tarea 3: Modificación de nuestra aplicación

Vamos a realizar cambios en el entorno de desarrollo y posteriormente vamos a subirlas a producción. Vamos a realizar tres modificaciones (entrega una captura de pantalla donde se ven cada una de ellas). Recuerda que primero lo haces en el entrono de desarrollo, y luego tendrás que llevar los cambios a producción:

* Modifica la página inicial donde se ven las encuestas para que aparezca tu nombre: Para ello modifica el archivo django_tutorial/polls/templates/polls/index.html.

```sh
nano django_tutorial/polls/templates/polls/index.html.
```

![nombre.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/nombre.png)

* Modifica la imagen de fondo que se ve la aplicación.

![fondo.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/fondo.png)

* Vamos a crear una nueva tabla en la base de datos, para ello sigue los siguientes pasos

Añadimos un nuevo modelo a **polls/models.py**:

```sh
  class Categoria(models.Model):	
  	Abr = models.CharField(max_length=4)
  	Nombre = models.CharField(max_length=50)

  	def __str__(self):
  		return self.Abr+" - "+self.Nombre 
```
Crea una nueva migración y realiza la migración

```sh
(django) celiagm@debian:~/github/django_tutorial$ python3 manage.py makemigrations
Migrations for 'polls':
  polls/migrations/0002_categoria.py
    - Create model Categoria


(django) celiagm@debian:~/github/django_tutorial$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, polls, sessions
Running migrations:
  Applying polls.0002_categoria... OK

```

Añade el nuevo modelo al sitio de administración de django.

```sh
from django.contrib import admin

from .models import Choice, Question, Categoria


class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 3


class QuestionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,               {'fields': ['question_text']}),
        ('Date information', {'fields': [
         'pub_date'], 'classes': ['collapse']}),
    ]
    inlines = [ChoiceInline]
    list_display = ('question_text', 'pub_date', 'was_published_recently')
    list_filter = ['pub_date']
    search_fields = ['question_text']


admin.site.register(Question, QuestionAdmin)
admin.site.register(Categoria)

```

![categoria1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/categoria1.png)

* Despliega el cambio producido al crear la nueva tabla en el entorno de producción.

![nombre1.png](https://github.com/CeliaGMqrz/utilidades/blob/main/practicas_sueltas/python_django/capturas/nombre1.png)


