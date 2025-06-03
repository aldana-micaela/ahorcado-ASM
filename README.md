# 🔧 Juego del Ahorcado en Assembler (ARM)

Este proyecto implementa el clásico juego del **ahorcado** en lenguaje ensamblador ARM, utilizando instrucciones de bajo nivel, interrupciones y acceso directo a memoria. Desarrollado como trabajo práctico para una materia de sistemas o arquitectura (por ejemplo, Organización de Computadoras I).

# 🧠 Conceptos y características destacadas
- 🔣 Lenguaje Assembler (ARM) – Proyecto escrito completamente en bajo nivel, manipulando registros, interrupciones y memoria.
- 🧠 Juego interactivo por consola – Muestra un mapa del ahorcado y recibe entradas de usuario carácter por carácter.
- Generación aleatoria de palabras.
- Validación de letras y control de letras repetidas.
- Control de vidas y dibujo progresivo del ahorcado.
- Gana o pierde según el progreso del jugador.

## 🎮 Lógica completa del juego:
- 🧩 Pregunta de recuperación – Si el jugador está por perder, puede recuperar una vida respondiendo correctamente una pregunta de lógica binaria.
- 🗺️ Coordenadas de rescate – Como último recurso, el jugador puede salvar al personaje ingresando las coordenadas correctas de la soga.
- 🧪 Sin dependencias externas – Funciona completamente con llamadas del sistema y manipulación directa de memoria.


## 🛠️ Tecnologías y conceptos aplicados

- Ensamblador ARM (Assembler)
- Acceso directo a registros y memoria
- Entrada de usuario por consola (sistema operativo)
- Generación de números aleatorios manual
- Estructuras de control y condicionales en bajo nivel
- Lógica de validación de letras y condiciones de victoria
- Manejo visual básico del "mapa" del ahorcado con caracteres ASCII

## 🎮 Características del juego

- Selección aleatoria de palabras clave sobre informática (transistor, binario, etc.)
- Revisión de letras ingresadas, detección de repetidas
- Dibujo progresivo del ahorcado según los errores
- Sistema de vidas con posibilidad de ganar una extra respondiendo una pregunta binaria
- Oportunidad de rescatar al personaje ingresando coordenadas correctas
- Mensajes de victoria o derrota impresos por consola

## 📂 Estructura del archivo

- `ahorcado.asm` → Código fuente completo del juego

## 🚀 Cómo correr el programa

Este código está diseñado para entornos que soporten ejecución de ARM Assembler, por ejemplo:

- QEMU con Linux ARM
- Emuladores educativos
- Raspberry Pi con entorno de desarrollo
- Sistemas configurados para prácticas de Arquitectura o Sistemas Operativos

## 👩‍💻 Autora
```
Aldana Micaela Filiberto
Estudiante de Licenciatura en Sistemas 
Este proyecto fue desarrollado como parte de una práctica académica para aplicar conocimientos sobre arquitectura de computadoras, manejo de registros y lógica de programación de bajo nivel.
```
