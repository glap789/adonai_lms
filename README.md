# Guía de Despliegue en Railway

Esta guía te ayudará a desplegar el proyecto **Sistema de Gestión Escolar Laravel** en Railway.

## 📋 Requisitos Previos

- Cuenta en [Railway](https://railway.app/)
- Cuenta en [GitHub](https://github.com/)
- Repositorio Git del proyecto
- MySQL configurado en Railway

---

## 🚀 Paso 1: Preparar el Proyecto

### 1.1 Verificar archivos necesarios

Asegúrate de tener estos archivos en tu repositorio:

```bash
.
├── public/
│   └── index.php          # Punto de entrada
├── composer.json          # Dependencias PHP
├── package.json           # Dependencias Node.js
├── .env.example           # Plantilla de variables de entorno
├── Procfile (opcional)    # Comandos de inicio
└── nixpacks.toml (opcional) # Configuración de build
```

### 1.2 Crear Procfile (si no existe)

Crea un archivo `Procfile` en la raíz del proyecto:

```
web: php artisan serve --host=0.0.0.0 --port=$PORT
```

### 1.3 Actualizar composer.json

Asegúrate de que `composer.json` tenga la versión correcta de PHP:

```json
{
  "require": {
    "php": "^8.2"
  }
}
```

---

## 🗄️ Paso 2: Configurar Base de Datos MySQL en Railway

### 2.1 Crear servicio MySQL

1. Ve a tu proyecto en Railway
2. Click en **"New"** → **"Database"** → **"Add MySQL"**
3. Railway creará automáticamente las variables de entorno:
   - `MYSQL_HOST`
   - `MYSQL_PORT`
   - `MYSQL_USER`
   - `MYSQL_PASSWORD`
   - `MYSQL_DATABASE`

### 2.2 Importar base de datos (opcional)

Si tienes un dump SQL:

```bash
# Conectarse a MySQL de Railway
mysql -h MYSQL_HOST -P MYSQL_PORT -u MYSQL_USER -p MYSQL_DATABASE < bd.sql
```

---

## 📦 Paso 3: Desplegar en Railway

### 3.1 Conectar repositorio GitHub

1. Ve a [railway.app](https://railway.app)
2. Click en **"New Project"**
3. Selecciona **"Deploy from GitHub repo"**
4. Autoriza Railway para acceder a tu GitHub
5. Selecciona el repositorio del proyecto

### 3.2 Configurar variables de entorno

En el dashboard de Railway, ve a **"Variables"** y agrega:

```env
# Aplicación
APP_NAME="Colegio Adonai"
APP_ENV=production
APP_KEY=base64:TU_APP_KEY_AQUI
APP_DEBUG=false
APP_URL=https://tu-proyecto.up.railway.app

# Base de datos (automáticas de Railway)
DB_CONNECTION=mysql
DB_HOST=${MYSQL_HOST}
DB_PORT=${MYSQL_PORT}
DB_DATABASE=${MYSQL_DATABASE}
DB_USERNAME=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}

# Configuración de sesión
SESSION_DRIVER=database
SESSION_LIFETIME=120

# Cache
CACHE_STORE=database
QUEUE_CONNECTION=database

# Mail (opcional)
MAIL_MAILER=log

# Locales
APP_LOCALE=es
APP_FALLBACK_LOCALE=en
```

### 3.3 Generar APP_KEY

Ejecuta localmente y copia el resultado:

```bash
php artisan key:generate --show
```

O usa Railway CLI:

```bash
railway run php artisan key:generate
```

---

## ⚙️ Paso 4: Configurar Build y Deploy

### 4.1 Crear nixpacks.toml (recomendado)

Crea `nixpacks.toml` en la raíz:

```toml
[phases.setup]
nixPkgs = ["php82", "php82Packages.composer", "nodejs_20"]

[phases.install]
cmds = [
  "composer install --no-dev --optimize-autoloader",
  "npm ci --production=false",
  "npm run build"
]

[phases.build]
cmds = [
  "php artisan config:cache",
  "php artisan route:cache",
  "php artisan view:cache"
]

[start]
cmd = "php artisan serve --host=0.0.0.0 --port=$PORT"
```

### 4.2 Configurar permisos de storage

Railway ejecutará automáticamente:

```bash
chmod -R 775 storage bootstrap/cache
```

---

## 🔧 Paso 5: Post-Deploy

### 5.1 Ejecutar migraciones

En Railway CLI o desde la consola del dashboard:

```bash
railway run php artisan migrate --force
```

### 5.2 Crear roles y usuarios

```bash
railway run php artisan db:seed --class=RolesSeeder
```

### 5.3 Hashear contraseñas (si es necesario)

Si importaste usuarios con contraseñas no hasheadas:

```bash
railway run php artisan users:hash-passwords --password=123456789
```

### 5.4 Limpiar caché

```bash
railway run php artisan optimize:clear
railway run php artisan config:cache
railway run php artisan route:cache
railway run php artisan view:cache
```

---

## 🌐 Paso 6: Configurar Dominio

### 6.1 Dominio de Railway (automático)

Railway te proporciona un dominio:
```
https://tu-proyecto.up.railway.app
```

### 6.2 Dominio personalizado (opcional)

1. Ve a **"Settings"** → **"Domains"**
2. Click en **"Add Custom Domain"**
3. Ingresa tu dominio: `ejemplo.com`
4. Configura los registros DNS en tu proveedor:

```
CNAME @ tu-proyecto.up.railway.app
```

---

## 📊 Monitoreo y Logs

### Ver logs en tiempo real

```bash
railway logs
```

### Ver logs desde el dashboard

1. Ve a tu proyecto en Railway
2. Click en **"Deployments"**
3. Selecciona el deployment
4. Click en **"View Logs"**

---

## 🔒 Seguridad

### Checklist de seguridad

- [x] `APP_DEBUG=false` en producción
- [x] `APP_ENV=production`
- [x] Contraseñas hasheadas con bcrypt
- [x] Variables de entorno configuradas
- [x] SSL/HTTPS habilitado (automático en Railway)
- [x] Archivos `.env` en `.gitignore`

---

## 🐛 Troubleshooting

### Error: "Class MenuFilter does not exist"

**Solución:** Elimina la referencia en `config/adminlte.php`:

```php
// Eliminar esta línea:
App\Http\MenuFilter::class,
```

### Error: "This password does not use Bcrypt algorithm"

**Solución:** Ejecuta el comando para hashear contraseñas:

```bash
railway run php artisan users:hash-passwords
```

### Error 500 en producción

**Pasos:**

1. Revisa los logs: `railway logs`
2. Verifica variables de entorno
3. Limpia caché: `railway run php artisan optimize:clear`
4. Verifica migraciones: `railway run php artisan migrate:status`

### Assets no cargan (CSS/JS)

**Solución:** Asegúrate de que Vite haya compilado los assets:

```bash
npm run build
```

Y que `APP_URL` esté correctamente configurado en `.env`

---

## 📝 Comandos Útiles

```bash
# Ver estado del proyecto
railway status

# Ejecutar comandos en Railway
railway run php artisan [comando]

# Conectarse a la base de datos
railway run mysql -u root

# Ver variables de entorno
railway variables

# Reiniciar el servicio
railway restart

# Eliminar caché
railway run php artisan optimize:clear
```

---

## 🔄 Actualizar Despliegue

### Despliegue automático (recomendado)

Railway despliega automáticamente cuando haces push a la rama principal:

```bash
git add .
git commit -m "Descripción de cambios"
git push origin main
```

### Despliegue manual

1. Ve al dashboard de Railway
2. Click en **"Deployments"**
3. Click en **"Deploy"**

---

## 📚 Recursos Adicionales

- [Documentación de Railway](https://docs.railway.app/)
- [Documentación de Laravel Deployment](https://laravel.com/docs/deployment)
- [Railway CLI](https://docs.railway.app/develop/cli)

---

## ✅ Checklist de Despliegue

- [ ] Repositorio en GitHub configurado
- [ ] MySQL creado en Railway
- [ ] Variables de entorno configuradas
- [ ] `APP_KEY` generada
- [ ] Build exitoso
- [ ] Migraciones ejecutadas
- [ ] Roles y usuarios creados
- [ ] Assets compilados (npm run build)
- [ ] Dominio configurado
- [ ] Logs revisados sin errores
- [ ] Aplicación funcionando correctamente

---

## 🆘 Soporte

Si encuentras problemas durante el despliegue:

1. Revisa los logs: `railway logs`
2. Consulta la documentación oficial
3. Verifica las variables de entorno
4. Contacta al equipo de desarrollo

---

**Última actualización:** Noviembre 2025
**Versión del proyecto:** Laravel 12.x | PHP 8.2 | MySQL 8.0
