# RR EVOLUTION — Prototipo funcional v0.1

Interfaz responsive e instalable (PWA) para explorar el flujo principal de RR EVOLUTION. Incluye panel de entrenador, vista de alumno, perfiles, biblioteca de rutinas y alimentación, historial de progreso y formularios de seguimiento.

## Importante: alcance de esta entrega

Esta carpeta contiene un **prototipo frontend de demostración**, no una plataforma de producción. Los datos se guardan únicamente en el almacenamiento local del navegador (`localStorage`) y los alumnos incluidos son ficticios. No utilizar nombres, correos, datos físicos, fotografías ni información real de alumnos. No hay autenticación, sincronización entre dispositivos, base de datos remota, mensajería real ni notificaciones push en esta versión.

## Cómo probarlo

1. Descomprimir la carpeta.
2. Abrir `index.html` en un navegador para explorar la interfaz (el modo PWA/offline requiere servirlo por HTTPS o localhost).
3. Cambiar entre “Panel entrenador” y “Vista del alumno” desde el selector lateral.
4. Probar las acciones de agregar alumno, modificar planes y registrar un check-in. Los cambios quedan en ese navegador y pueden borrarse desde el almacenamiento del sitio.

Para probar la instalación PWA, servir la carpeta mediante un servidor local/HTTPS. En Android, usar “Instalar aplicación”. En iPhone, abrir en Safari y elegir “Añadir a pantalla de inicio”. La disponibilidad exacta de funciones instalables depende del navegador y del sistema operativo.

## Siguiente etapa necesaria para producción

- Conectar Replit para desarrollo, despliegue y gestión del proyecto.
- Configurar Supabase (PostgreSQL + Auth + Storage) como backend.
- Implementar cuentas y roles `admin` / `student`, recuperación de contraseña y reglas de acceso por alumno.
- Activar Row Level Security en todas las tablas y almacenamiento privado para documentos e imágenes.
- Añadir historial de versiones, auditoría, notificaciones, copias de seguridad y consentimiento informado.
- Probar en dispositivos reales y revisar privacidad, seguridad y requisitos legales argentinos antes de incorporar alumnos.

## Identidad visual

Tema oscuro, detalles dorados y monograma RR provisional. Reemplazar el monograma por el archivo oficial de logo cuando se proporcione.
