# Instrucciones para continuar RR EVOLUTION en Replit

Tomá este proyecto RR EVOLUTION v0.1 como base visual y funcional. Convertí el prototipo en una aplicación de producción, responsive y PWA instalable en Android y iPhone, con panel de entrenador que también funcione en computadora. Mantener identidad visual premium: negro, dorado, monograma RR provisional y textos en español rioplatense neutro.

## Roles y acceso
- Dos roles: `admin` (Ramiro / entrenador) y `student` (cada alumno).
- Implementar autenticación real, recuperación de contraseña, invitaciones de alumnos y cierre de sesión.
- El alta de cuentas administrativas no debe quedar abierta al público.
- El alumno solo puede ver su propia ficha, sus planes publicados, sus mensajes y sus registros.
- El administrador puede gestionar alumnos, planes, versiones, mensajes y seguimiento.
- Asegurar todas las rutas en servidor; no confiar en controles ocultos de la interfaz.

## Backend y seguridad
- Usar Supabase Auth + PostgreSQL + Storage privado.
- Crear el esquema según `DATABASE_PLAN.sql`, revisarlo y completarlo.
- Activar Row Level Security en todas las tablas y escribir políticas restrictivas probadas para admin y student.
- No guardar datos de alumnos, medidas, fotografías, credenciales ni sesiones sensibles en localStorage.
- Guardar fotografías/documentos en buckets privados con URL firmada y vencimiento; validar tipo y tamaño.
- Incorporar auditoría de altas, cambios, publicaciones, mensajes y registros.
- Validar entradas en cliente y servidor, usar HTTPS, manejo seguro de secretos por variables de entorno, copias de seguridad y logs sin datos sensibles.
- Incluir consentimiento y aviso de privacidad antes de registrar datos personales. Preparar la plataforma para revisión de la normativa argentina de protección de datos.

## Módulos obligatorios — primera versión
1. **Panel de entrenador:** número de alumnos, estados, seguimientos pendientes, actividad reciente y alertas de falta de check-in.
2. **Alumnos:** alta, edición, baja lógica, búsqueda, objetivo, datos de contacto, estado y ficha individual.
3. **Rutinas:** crear/duplicar/editar planes; días; ejercicios; series; repeticiones; descansos; notas; cargas registradas por el alumno. Publicar una versión nueva sin destruir la anterior.
4. **Alimentación:** planes por alumno; comidas; horarios; ingredientes; cantidades; unidad; alternativas; indicación de si el peso es crudo/cocido; notas y versiones. No generar recomendaciones clínicas autónomas.
5. **Seguimiento:** check-in del alumno con fecha, peso, medidas opcionales, adherencia percibida y comentarios. Fotos solo con consentimiento, acceso privado y posibilidad de borrar.
6. **Mensajería:** conversación privada entrenador-alumno y notificación de mensajes/cambios de plan.
7. **Experiencia de alumno:** inicio claro con planes vigentes, calendario semanal, completar sesión, consultar comida, enviar check-in e historial.

## Fuera de alcance por ahora
- No implementar cobros, Mercado Pago, suscripciones ni membresías en esta versión. Dejar arquitectura preparada para agregarlos posteriormente.
- No simular sincronización en tiempo real si no está implementada.

## Criterios de aceptación
- Un administrador puede invitar a un alumno y asignarle una rutina y un plan alimentario.
- El alumno inicia sesión y solo ve su propia información.
- Una modificación publicada crea una nueva versión y notifica al alumno.
- El alumno puede marcar sesiones realizadas y enviar un seguimiento.
- El administrador ve los nuevos datos sin tener que pedirlos por WhatsApp.
- Las pruebas verifican que el alumno A no puede acceder a datos del alumno B, incluso llamando directamente a la API.
- Funciona en pantallas pequeñas y escritorio; probar en Safari iOS y Chrome Android.
- Documentar despliegue, configuración, backups, variables de entorno, recuperación y pasos de publicación.

Antes de desplegar, eliminar datos ficticios de demostración y comprobar permisos, RLS, consentimiento, políticas de privacidad y pruebas de acceso cruzado. No cargar alumnos reales hasta completar revisión de seguridad.
