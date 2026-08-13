# Guia rapida para Ruby

## Variables

### Variables locales

Empiezan con letra minúscula o guion bajo.

```ruby
nombre = "Ana"
_edad = 25
```

- Ámbito: método, bloque, clase o módulo donde se definen.

- No son accesibles fuera de su contexto.

### Variables de instancia

Pertenece a un objeto especifico. Cada instancia tiene la suya propia.

Prefijo `@` .

```ruby
class Persona
  def initialize(nombre)
    @nombre = nombre
  end
end
```

- Pertenecen a una instancia específica de una clase.

- Inicializan en `nil` si no se les asigna valor.

- Accesibles desde métodos de instancia de esa clase.

```ruby
class Producto
  def initialize(nombre, precio)
    @nombre = nombre   # variable de instancia
    @precio = precio
  end

  def mostrar
    "#{@nombre}: $#{@precio}"
  end

  def rebajar(porcentaje)
    @precio -= @precio * porcentaje / 100.0
  end
end

p1 = Producto.new("Laptop", 1000)
p2 = Producto.new("Mouse", 25)

puts p1.mostrar   # Laptop: $1000
puts p2.mostrar   # Mouse: $25

p1.rebajar(10)
puts p1.mostrar   # Laptop: $900  (solo cambió p1, p2 sigue igual)
```

**Clave:** `@precio` en `p1` y `@precio` en `p2` son **dos variables distintas**.

### Variables de clase

Es **compartida** por la clase y **todas** sus instancias (incluyendo subclases).

Prefijo `@@` .

```ruby
class Contador
  @@total = 0
end
```

- Compartidas entre **todas** las instancias de la clase y sus subclases.

- Si una subclase las modifica, afecta a la clase padre también.

```ruby
class Empleado
  @@total_empleados = 0   # variable de clase

  def initialize(nombre)
    @nombre = nombre
    @@total_empleados += 1
  end

  def self.cuantos
    @@total_empleados
  end

  def reporte
    "Soy #{@nombre}. Empleados totales: #{@@total_empleados}"
  end
end

e1 = Empleado.new("Ana")
e2 = Empleado.new("Luis")
e3 = Empleado.new("Pedro")

puts Empleado.cuantos        # 3
puts e1.reporte              # Empleados totales: 3
puts e2.reporte              # Empleados totales: 3
```

**Clave:** `@@total_empleados` es **una sola** para toda la jerarquía de `Empleado`. Si creas una subclase, también compartirá esa variable.

### Variables globales

Accesible desde **cualquier lugar** del programa.

Prefijo `$`.

```ruby
$app_name = "MiApp"
```

- Accesibles desde cualquier parte del programa.

- Ruby define algunas predefinidas (`$0`, `$$`, `$LOAD_PATH`, etc.).

- **Evitar su uso** salvo casos muy específicos.

```ruby
$modo_debug = false   # variable global

class Servidor
  def iniciar
    if $modo_debug
      puts "[DEBUG] Iniciando servidor en modo detallado..."
    else
      puts "Servidor iniciado."
    end
  end
end

class Cliente
  def conectar
    puts $modo_debug ? "[DEBUG] Conectando..." : "Conectado."
  end
end

servidor = Servidor.new
cliente = Cliente.new

servidor.iniciar   # Servidor iniciado.
cliente.conectar   # Conectado.

$modo_debug = true
servidor.iniciar   # [DEBUG] Iniciando servidor en modo detallado...
```

**Clave:** `$modo_debug` puede leerse y modificarse desde `Servidor`, `Cliente`, o cualquier otro archivo/módulo.

### Comparación rápida

```ruby
class Demo
  $global = "soy global"
  @@clase = "soy de clase"
  
  def initialize
    @instancia = "soy de instancia"
  end

  def mostrar
    puts $global      # ✅ accesible
    puts @@clase      # ✅ accesible
    puts @instancia   # ✅ accesible
  end
end

d = Demo.new
d.mostrar

puts $global        # ✅ desde fuera de la clase
# puts @@clase      # ❌ Error: no accesible desde fuera
# puts @instancia   # ❌ Error: no accesible desde fuera
```



### Constantes

Empiezan con mayúscula.

```ruby
PI = 3.14159
MAX_INTENTOS = 3
```

- Definidas en clases o módulos; accesibles desde fuera si se referencian correctamente.

- Ruby **permite** reasignarlas, pero emite una advertencia.

### Pseudo-variables

No son variables en el sentido estricto; son palabras reservadas que actúan como valores fijos:

- `self` — referencia al objeto actual.

- `nil`, `true`, `false` — únicos valores de sus respectivas clases.

- `__FILE__`, `__LINE__`, `__dir__`, `__ENCODING__` — metadatos del código.

### Variables de bloque / parametros de bloque

```ruby
[1, 2, 3].each do |num|
  puts num
end
```

`num` es local al bloque. Ruby 3 mantiene el comportamiento de que no "fugan"
 al ámbito exterior (a diferencia de versiones muy antiguas).

#### Extra: variables de hilo y fibra

Aunque no son sintaxis de prefijo, Ruby permite almacenar datos asociados a un hilo o fibra:

```ruby
Thread.current[:usuario] = "admin"
Fiber.current[:dato] = 42
```

**Resumen visual de prefijos:**

| Tipo      | Prefijo     | Ejemplo   |
| --------- | ----------- | --------- |
| Local     | `a-z` o `_` | `nombre`  |
| Instancia | `@`         | `@nombre` |
| Clase     | `@@`        | `@@total` |
| Global    | `$`         | `$debug`  |
| Constante | `A-Z`       | `MAX`     |



## Convenciones de nomenclatura de variables en Ruby

En Ruby se usa **snake_case** (lo que llamas "serpent case") para casi todo.

Aquí va la convención oficial:

| Elemento               | Convención               | Ejemplo                              |
| ---------------------- | ------------------------ | ------------------------------------ |
| Variables locales      | `snake_case`             | `nombre_usuario`, `total_precio`     |
| Variables de instancia | `@snake_case`            | `@nombre`, `@contador`               |
| Variables de clase     | `@@snake_case`           | `@@instancia_unica`                  |
| Métodos                | `snake_case`             | `calcular_total`, `esta_activo?`     |
| Constantes             | `UPPER_SNAKE_CASE`       | `MAX_INTENTOS`, `PI`                 |
| Clases / Módulos       | `CamelCase` (PascalCase) | `UsuarioController`, `ModuloDePagos` |

Ruby sigue la filosofía de **legibilidad sobre velocidad de escritura**. `snake_case` es más fácil de leer para el ojo humano, y Ruby prioriza la "felicidad del desarrollador".

Además, RuboCop (el linter estándar) te marcará como error cualquier variable o método en `camelCase`:

```ruby
# ❌ Mal (RuboCop se queja)
nombreUsuario = "Ana"
def calcularTotal; end

# ✅ Bien
nombre_usuario = "Ana"
def calcular_total; end
```

### Excepción: Clases y Módulos

Las **clases** y **módulos** sí usan `CamelCase` (o PascalCase), porque representan "entidades" o "tipos":

```ruby
class UsuarioAutenticado
  attr_reader :nombre_completo

  def initialize(nombre_completo)
    @nombre_completo = nombre_completo
  end

  def esta_verificado?
    @nombre_completo.length > 0
  end
end
```

### Regla mnemotécnica

> **"Si es una acción o un dato, usa `snake_case`. Si es un tipo o una categoría, usa `CamelCase`."**

## Strings

### Comillas simples vs dobles

| Tipo    | Interpolacion | Secuencias de escape            |
| ------- | ------------- | ------------------------------- |
| `'...'` | ❌ No          | Solo `\'` y \`\\\\`             |
| `"..."` | ✅ Sí          | Todas (`\n`, `\t`, `\x41`, etc) |

```ruby
nombre = "Ana"
puts 'Hola #{nombre}'   # => Hola #{nombre}   (literal)
puts "Hola #{nombre}"   # => Hola Ana         (interpolado)
puts 'Salto\nlinea'     # => Salto\nlinea     (literal)
puts "Salto\nlinea"     # => Salto            (newline real)
#                           linea
```

### Interpolación

Dentro de `"..."` puedes ejecutar código Ruby con `#{}`:

```ruby
edad = 30
puts "Tienes #{edad} años"           # => Tienes 30 años
puts "El doble es #{edad * 2}"       # => El doble es 60
puts "¿Mayor? #{edad > 18 ? 'Sí' : 'No'}"  # => ¿Mayor? Sí
```

Si interpolas solo una variable, también puedes usar el atajo `#@variable` (poco común hoy en día):

```ruby
@nombre = "Luis"
puts "Hola #@nombre"   # => Hola Luis
```

### Strings multilínea (Heredocs)

Para textos largos, usa heredocs:

```ruby
poema = <<~TEXTO
  Ruby es elegante,
  simple y poderoso.
  Me encanta #{1 + 1}.
TEXTO

puts poema
# Ruby es elegante,
# simple y poderoso.
# Me encanta 2.
```

- `<<TEXTO` — respeta indentación exacta (incluye los espacios del código).

- `<<~TEXTO` — **quita el indentado común** (el más útil, desde Ruby 2.3).

- El delimitador (`TEXTO`) puede ser cualquier palabra en mayúsculas.

### Mutabilidad: ¡los strings son mutables por defecto!

Esta es la regla que más bugs causa:

```ruby
saludo = "Hola"
saludo << " mundo"      # << modifica el string in-place
puts saludo             # => "Hola mundo"

otro = saludo
otro.upcase!            # ¡También modifica saludo!
puts saludo             # => "HOLA MUNDO"
```

**Cada literal de string crea un nuevo objeto**, a menos que uses `.freeze` o literales congelados.

**Congelar strings**

```ruby
# Opción 1: freeze individual
NOMBRE = "Ana".freeze
NOMBRE << "!"   # => FrozenError

# Opción 2: magic comment (congela TODOS los literales del archivo)
# frozen_string_literal: true

saludo = "Hola"   # Ahora es inmutable automáticamente
saludo << "!"     # => FrozenError
```

Desde Ruby 3.0, los **literals de string en archivos con `frozen_string_literal: true` son internados y reutilizados**, como los símbolos.

### Símbolos (`:nombre`) vs. Strings

Los símbolos son **inmutables y únicos** en memoria. Se usan para identificadores, no para texto manipulable:

```ruby
:activo.object_id   # => 123456
:activo.object_id   # => 123456  (mismo objeto)

"activo".object_id  # => 789012
"activo".object_id  # => 345678  (objetos distintos)
```

Regla práctica:

- **String** → texto que muestras al usuario, datos, contenido.

- **Symbol** → claves de hash, nombres de estados, flags internos.

### Concatenación: cuidado con `+` vs. `<<`

```ruby
a = "Hola"
b = " mundo"

# + crea un NUEVO string (más lento, más memoria)
c = a + b

# << modifica el receptor (más rápido, cuidado con efectos colaterales)
a << b
```

Para concatenar muchas piezas, usa un array + `join` (es el patrón más eficiente):

```ruby
partes = ["Hola", " ", "mundo", "!"]
resultado = partes.join   # => "Hola mundo!"
```

### Encoding

Ruby 3 maneja UTF-8 por defecto, pero puedes verificar y convertir:

```ruby
texto = "Ruby 🚀"
puts texto.encoding       # => #<Encoding:UTF-8>

latin = texto.encode("ISO-8859-1")   # Convierte
puts latin.encoding        # => #<Encoding:ISO-8859-1>
```

Si lees archivos externos, especifica el encoding:

```ruby
contenido = File.read("datos.txt", encoding: "UTF-8")
```

### Métodos útiles imprescindibles

```ruby
texto = "  Hola Mundo  "

texto.strip           # => "Hola Mundo"  (quita espacios)
texto.downcase        # => "  hola mundo  "
texto.upcase          # => "  HOLA MUNDO  "
texto.capitalize      # => "  hola mundo  " (solo primera letra)
texto.split           # => ["Hola", "Mundo"]
texto.include?("la")  # => true
texto.start_with?(" ")# => true
texto.empty?          # => false
texto.length          # => 15
texto.gsub("Mundo", "Ruby")  # => "  Hola Ruby  "  (reemplazo global)
texto.sub("o", "0")   # => "  H0la Mundo  "  (solo primera coincidencia)

# Búsqueda con regex
texto.match?(/Hola/)  # => true
texto.scan(/\w+/)     # => ["Hola", "Mundo"]
```

### `%q` y `%Q` (strings con delimitadores personalizados)

Cuando tu string contiene muchas comillas, evita escapar:

```ruby
# %q es como comillas simples (sin interpolación)
html = %q{<div class="active">Hola</div>}

# %Q es como comillas dobles (con interpolación)
nombre = "Ana"
html = %Q{<h1>Hola #{nombre}</h1>}

# También puedes usar (), [], {}, ||, //, etc.
codigo = %q[if (x > 0) { return true; }]
```

### Resumen de reglas clave

| Regla                                           | Descripción                                                     |
| ----------------------------------------------- | --------------------------------------------------------------- |
| `"..."` para interpolar, `'...'` para literales | Usa la comilla correcta según necesites `#{}`                   |
| `<<` modifica, `+`crea nuevo                    | Cuidado con la mutabilidad                                      |
| `.freeze` o `frozen_string_literal`             | Para strings inmutables y eficientes                            |
| `<<~HEREDOC`                                    | Para textos multilínea limpios                                  |
| Símbolos para identificadores                   | No uses strings como claves de hash si no necesitas mutabilidad |
| `join` para concatenar muchas partes            | Más eficiente que `+` en bucles                                 |

## Tipos de datos numericos en Ruby

En Ruby los números son objetos de primera clase, y el lenguaje hace algunas cosas muy elegantes que otros lenguajes no hacen. Aquí va todo lo esencial:

```ruby
# Ruby antiguo (pre-2.4) tenía Fixnum y Bignum. Ahora todo es Integer.
puts 42.class           # => Integer
puts 999999999999999999999999999999.class  # => Integer (internamente es Bignum, pero transparente)

# Operaciones básicas
puts 10 + 3             # => 13
puts 10 - 3             # => 7
puts 10 * 3             # => 30
puts 10 / 3             # => 3  (división entera)
puts 10 % 3             # => 1  (módulo/resto)
puts 10 ** 3            # => 1000 (potencia)
```

#### División entera vs. flotante

```ruby
puts 10 / 3             # => 3     (Integer / Integer = Integer)
puts 10 / 3.0           # => 3.3333333333333335  (Integer / Float = Float)
puts 10.fdiv(3)         # => 3.3333333333333335  (forzar división flotante)
```

### ## `Float` — Punto flotante (IEEE 754)

Los `Float` son de doble precisión (64 bits). Tienen las mismas limitaciones de precisión que en cualquier lenguaje.

```ruby
puts 3.14159.class      # => Float
puts 1.0e5              # => 100000.0  (notación científica)
puts 1.5e-3             # => 0.0015

# ⚠️ Clásico problema de precisión
puts 0.1 + 0.2          # => 0.30000000000000004
puts 0.1 + 0.2 == 0.3   # => false
```

Para comparaciones con floats, usa una tolerancia:

```ruby
(0.1 + 0.2 - 0.3).abs < 0.0001   # => true
```

### `Rational` — Números racionales (precisión exacta)

Ruby tiene soporte nativo para fracciones exactas. Evitan el problema de precisión de los floats.

```ruby
r = Rational(1, 3)      # => 1/3
puts r.class            # => Rational

# Operaciones exactas
puts Rational(1, 3) + Rational(1, 6)   # => 1/2
puts Rational(2, 4)                     # => 1/2 (simplifica automáticamente)

# Convertir desde string o float
puts "1/3".to_r         # => 1/3
puts 0.5.to_r           # => 1/2
```

### `Complex` — Números complejos

```ruby
c = Complex(2, 3)       # => 2+3i
puts c.class            # => Complex

puts c + Complex(1, 1)  # => 3+4i
puts c.abs              # => 3.605551275463989  (módulo)
puts c.conjugate        # => 2-3i
```

### `BigDecimal` — Precisión decimal arbitraria

No es una clase core, pero viene en la librería estándar. Esencial para dinero, finanzas o cualquier cálculo donde la precisión decimal sea crítica.

```ruby
require 'bigdecimal'

a = BigDecimal("0.1")
b = BigDecimal("0.2")
puts a + b              # => 0.3e0  (exacto)
puts (a + b) == BigDecimal("0.3")  # => true

# Para dinero
precio = BigDecimal("19.99")
cantidad = BigDecimal("3")
total = precio * cantidad
puts total.to_s('F')    # => "59.97"  (formato fijo, sin notación científica)
```

**Regla de oro**: Nunca uses `Float` para dinero. Usa `BigDecimal` o `Integer` (guarda todo en centavos).

### Coerción de tipos (type coercion)

Ruby hace coerciones automáticas en operaciones mixtas, siguiendo una jerarquía:

```
Integer < Float < Complex
Rational < Float < Complex
```

```ruby
puts 1 + 2.5            # => 3.5  (Integer + Float = Float)
puts 1 + Rational(1, 2) # => 3/2  (Integer + Rational = Rational)
puts 1.5 + Rational(1, 2)  # => 2.0  (Float + Rational = Float)
puts 1 + 2.0i           # => 1+2.0i  (Integer + Complex = Complex)
```

### Métodos útiles de números

```ruby
n = -42

puts n.abs              # => 42
puts n.even?            # => true
puts n.odd?             # => false
puts n.positive?        # => false
puts n.negative?        # => true
puts n.zero?            # => false
puts n.digits           # => [2, 4] (array de dígitos, little-endian)
puts 42.digits          # => [2, 4]

# Redondeo
puts 3.7.floor          # => 3
puts 3.2.ceil           # => 4
puts 3.5.round          # => 4
puts 3.14159.round(2)   # => 3.14
puts 3.14159.truncate   # => 3 (igual que floor para positivos)

# Rangos y pasos
puts (1..10).sum        # => 55
puts (1..10).step(2).to_a  # => [1, 3, 5, 7, 9]

# Tiempo
puts 5.times { |i| print i }   # => 01234
puts 3.upto(5) { |i| print i } # => 345
puts 5.downto(3) { |i| print i } # => 543
```

### Literales y sintaxis especiales

```ruby
# Separador de miles (solo visual, Ruby lo ignora)
puts 1_000_000          # => 1000000
puts 1_000_000_000      # => 1000000000

# Bases numéricas
puts 0b1010             # => 10  (binario)
puts 0o17               # => 15  (octal)
puts 0xFF               # => 255 (hexadecimal)
puts 0d42               # => 42  (decimal explícito)

# Conversión entre tipos
puts "42".to_i          # => 42
puts "42.5".to_f        # => 42.5
puts "3/4".to_r         # => 3/4
puts "2+3i".to_c        # => 2+3i
puts 42.to_s            # => "42"
puts 42.to_s(16)        # => "2a" (base 16)
puts 42.to_s(2)         # => "101010" (base 2)
```

### Resumen de tipos numéricos

| Tipo         | Uso                            | Precisión                                |
| ------------ | ------------------------------ | ---------------------------------------- |
| `Integer`    | Conteos, índices, IDs          | Exacta, ilimitada                        |
| `Float`      | Cálculos científicos, gráficos | ~15 decimales (aproximada)               |
| `Rational`   | Fracciones matemáticas exactas | Exacta                                   |
| `Complex`    | Ingeniería, física             | Depende de las partes (Float o Rational) |
| `BigDecimal` | Dinero, impuestos, finanzas    | Exacta, configurable                     |

### Regla mnemotécnica

> **¿Es dinero?** → `BigDecimal` o `Integer` (centavos)  
> **¿Es una fracción exacta?** → `Rational`  
> **¿Es física o 3D?** → `Float` o `Complex`  
> **¿Es todo lo demás?** → `Integer`

## Moneda segura Ruby

Manejar dinero en Ruby es un tema donde **un solo error de precisión puede costarte dinero real**. Aquí va el enfoque profesional:

#### NUNCA uses `Float` para dinero

Los floats usan binario de punto flotante (IEEE 754). Números como `0.1` no tienen representación exacta en binario, así que se almacenan como aproximaciones. Al operar, esos errores se acumulan.

```ruby
# ❌ CATASTRÓFICO para dinero
total = 0.1 + 0.2          # => 0.30000000000000004
puts total == 0.3          # => false

# Un ejemplo real: sumar 10 veces $0.10
suma = 0.0
10.times { suma += 0.10 }
puts suma                  # => 0.9999999999999999  (¡te falta un centavo!)
```

Si guardas eso en una base de datos, redondeas mal, o comparas montos, tendrás discrepancias que son imposibles de rastrear.

#### Opción A: `BigDecimal` (la base de todo)

Viene en la librería estándar. Es preciso porque almacena el número como
 una cadena de dígitos decimales internamente, no como binario.

```ruby
require 'bigdecimal'
require 'bigdecimal/util'   # para el método .to_d

precio = BigDecimal("19.99")
cantidad = BigDecimal("3")
total = precio * cantidad

puts total                 # => 0.5997e2
puts total.to_s('F')       # => "59.97"  (formato fijo, sin notación científica)
puts total == BigDecimal("59.97")  # => true
```

##### Reglas con `BigDecimal`

**Siempre inicializa desde `String`**, no desde `Float`:

```ruby
# ❌ Mal: convierte el float impreciso a BigDecimal
BigDecimal(0.1)          # => 0.1000000000000000055511151231257827021181583404541015625e0

# ✅ Bien: construye directamente desde la representación decimal
BigDecimal("0.1")        # => 0.1e0
```

**Usa `.to_s('F')` para mostrar al usuario**:

```ruby
BigDecimal("59.97").to_s('F')   # => "59.97"
```

**Redondeo explícito**:

```ruby
iva = total * BigDecimal("0.16")
iva.round(2, :half_up)   # => 0.95952e1 → redondea a 2 decimales, "medio hacia arriba"
```

#### Opción B: La gema `money` (estándar en la industria)

Para proyectos reales, no reinventes la rueda. La gema `money` de RubyMoney es el estándar de facto. Maneja monedas, conversiones, formatos, símbolos, y precisión automáticamente.

```sh
gem install money
```

```ruby
require 'money'

# Configuración global
Money.default_currency = Money::Currency.new("MXN")

# Crear montos
precio = Money.new(1999, "MXN")     # 1999 centavos = $19.99 MXN
puts precio.format                  # => "$19.99"
puts precio.currency                # => #<Money::Currency ...>

# Operaciones seguras
cantidad = 3
total = precio * cantidad
puts total.format                   # => "$59.97"

# Otra moneda
usd = Money.new(1000, "USD")        # $10.00 USD
puts usd.format                     # => "$10.00"

# Suma de diferentes monedas (lanza error, evita conversiones silenciosas)
mxn = Money.new(1000, "MXN")
usd = Money.new(1000, "USD")
mxn + usd   # => Money::CurrencyDifferentArgError
```

#### ¿Por qué `Money` almacena en centavos (enteros)?

Internamente, `Money` guarda todo como **enteros** (centavos o la unidad más pequeña de cada moneda). Esto elimina por completo el problema de punto flotante:

```ruby
m = Money.new(1999, "USD")
m.cents        # => 1999  (Integer, exacto)
m.fractional   # => 1999  (alias)
```

| Moneda        | Unidad minima          | Ejemplo                |
| ------------- | ---------------------- | ---------------------- |
| USD, EUR, MXN | Centavos (100)         | `$19.99` → `1999`      |
| JPY           | Yen (1)                | `¥1000` → `1000`       |
| BTC           | Satoshis (100,000,000) | `0.00000001 BTC` → `1` |

#### Opción C: Guardar como `Integer` en la base de datos

Si usas Rails/ActiveRecord, el patrón más seguro es guardar la cantidad en centavos como `integer`:

```ruby
# db/migrate/xxx_create_productos.rb
create_table :productos do |t|
  t.integer :precio_cents, null: false, default: 0
  t.string  :precio_moneda, null: false, default: "MXN"
end
```

Y en el modelo:

```ruby
class Producto < ApplicationRecord
  # Con la gema 'money-rails'
  monetize :precio_cents, as: :precio
end

# Uso
producto = Producto.create(precio: Money.new(1999, "MXN"))
producto.precio.format   # => "$19.99"
```

La gema `money-rails` hace todo esto automáticamente.

#### Redondeo: la regla del "medio hacia arriba"

En finanzas, el redondeo no es trivial. Ruby soporta varios modos:

```ruby
require 'bigdecimal'

monto = BigDecimal("2.675")

# :half_up  — 0.5 siempre sube (el más común en comercio)
monto.round(2, :half_up)     # => 2.68

# :half_even — "Banker's rounding" (0.5 va al par más cercano, usado en contabilidad)
monto.round(2, :half_even)   # => 2.67

# :down — siempre trunca
monto.round(2, :down)        # => 2.67
```

**Regla**: Si no sabes qué usar, pregunta a tu contador. En la mayoría de e-commerce, `:half_up` es el esperado.

#### Comparaciones y validaciones

Con `Money` o `BigDecimal`, las comparaciones son exactas:

```ruby
# Con Money
a = Money.new(1000, "USD")
b = Money.new(1000, "USD")
a == b        # => true
a > Money.new(500, "USD")   # => true

# Con BigDecimal
BigDecimal("0.1") + BigDecimal("0.2") == BigDecimal("0.3")   # => true
```

#### Formato de presentación

La gema `money` maneja automáticamente símbolos, separadores de miles, y posición del símbolo según la localización:

```ruby
Money.new(199999, "USD").format   # => "$1,999.99"
Money.new(199999, "EUR").format   # => "€1.999,99"  (nota la coma y el punto)
Money.new(199999, "JPY").format   # => "¥199,999"   (sin decimales, JPY no usa centavos)
```

También puedes personalizar:

```ruby
Money.new(1999, "USD").format(
  symbol: true,
  decimal_mark: ".",
  thousands_separator: ",",
  with_currency: true
)   # => "$19.99 USD"
```

#### Resumen: ¿qué usar?

| Situación                     | Solución recomendada                                             |
| ----------------------------- | ---------------------------------------------------------------- |
| Script simple, sin gema extra | `BigDecimal("19.99")`                                            |
| Aplicación Rails/comercial    | Gema `money` + `money-rails`                                     |
| Base de datos                 | `integer` (centavos) + `string` (moneda)                         |
| API/JSON                      | Enviar siempre como string: `"19.99"` (nunca como float en JSON) |
| Comparaciones de precios      | `Money` o `BigDecimal`, nunca `Float`                            |

## Regla de oro

> **Si ves un `Float` cerca de dinero, hay un bug esperando a explotar.**

## Condicionales

Las condicionales en Ruby son expresivas, pero hay trampas que hacen el código confuso. Aquí va todo lo que necesitas saber:

### if / elsif / else

```ruby
# ✅ Básico y claro
def clasificar_edad(edad)
  if edad < 13
    :nino
  elsif edad < 20
    :adolescente
  elsif edad < 60
    :adulto
  else
    :adulto_mayor
  end
end
```

**Regla**: `elsif` en Ruby se escribe sin la segunda `e` (no `elseif`).

### unless -- la negativa elegante

`unless` es `if not`, pero **solo úsalo cuando la condición sea corta y legible**.

```ruby
# ✅ Bien: lectura fluida
enviar_correo unless usuario.bloqueado?

# ✅ Bien: una sola condición simple
return :error unless datos_validos?

# ❌ Mal: doble negativa mental
unless !usuario.inactivo?
  # ...
end

# ❌ Mal: con else (se lee como "a menos que X, sino Y" — confuso)
unless conectado?
  mostrar_offline
else
  mostrar_online
end

# ✅ Mejor:
if conectado?
  mostrar_online
else
  mostrar_offline
end
```

**Regla de oro**: Si necesitas `else`, usa `if`. Si la condición tiene `!`, `not`, `||`, `&&`, usa `if`.

### Guard clauses — el patrón más útil

En vez de anidar `if`, sal temprano.

```ruby
# ❌ Pirámide de la muerte
def procesar_pago(orden, usuario)
  if orden
    if usuario
      if usuario.activo?
        if orden.total > 0
          cobrar(orden)
        else
          :monto_invalido
        end
      else
        :usuario_inactivo
      end
    else
      :sin_usuario
    end
  else
    :sin_orden
  end
end

# ✅ Guard clauses: plano y explícito
def procesar_pago(orden, usuario)
  return :sin_orden unless orden
  return :sin_usuario unless usuario
  return :usuario_inactivo unless usuario.activo?
  return :monto_invalido unless orden.total.positive?

  cobrar(orden)
end
```

**Beneficio**: El "camino feliz" (el código principal) queda al final, sin indentación. Cada error se maneja y se olvida.

#### case / when — múltiples ramas limpias

Más elegante que `if/elsif/elsif` cuando comparas **contra valores concretos** o tipos.

```ruby
# ✅ Contra valores
def prioridad(nivel)
  case nivel
  when 1..3   then :baja
  when 4..6   then :media
  when 7..9   then :alta
  when 10     then :critica
  else :desconocida
  end
end

# ✅ Contra tipos (duck typing avanzado)
def describir(objeto)
  case objeto
  when String  then "Texto de #{objeto.length} caracteres"
  when Integer then "Número #{objeto}"
  when Array   then "Lista con #{objeto.size} elementos"
  else "Algo más"
  end
end

# ✅ Sin argumento (como una serie de if/elsif limpios)
case
when edad < 13  then :nino
when edad < 20  then :adolescente
when edad < 60  then :adulto
else :adulto_mayor
end
```

**Tip**: `then` es opcional si pones cada `when` en su propia línea. Úsalo solo en líneas cortas de una sola línea.

#### Pattern matching con case/in (Ruby 2.7+)

Para desestructurar estructuras complejas (arrays, hashes, objetos).

```ruby
# ✅ Desestructurar un hash anidado
respuesta = { usuario: { nombre: "Ana", edad: 30 }, estado: :ok }

case respuesta
in { usuario: { nombre:, edad: }, estado: :ok }
  puts "#{nombre} tiene #{edad} años"
in { error: mensaje }
  puts "Error: #{mensaje}"
else
  puts "Formato inesperado"
end

# ✅ Con arrays
case coordenadas
in [x, y] if x == y
  puts "Está en la diagonal"
in [0, *resto]
  puts "Empieza en cero, resto: #{resto}"
else
  puts "Otra cosa"
end
```

**Nota**: `case/in` es experimental en algunas versiones. Para código de producción crítico, muchos equipos aún prefieren `case/when` tradicional o guard clauses.

#### Operador ternario ?:

Úsalo para **asignaciones simples de una línea**, no para lógica compleja.

```ruby
# ✅ Asignación simple
estado = usuario.activo? ? :activo : :inactivo

# ✅ En un return
def saludo
  @nombre ? "Hola #{@nombre}" : "Hola invitado"
end

# ❌ Anidado (ilegible)
resultado = a > b ? (a > c ? a : c) : (b > c ? b : c)

# ✅ Mejor:
def maximo(a, b, c)
  return a if a > b && a > c
  return b if b > c
  c
end
```

#### `&&` vs `and`, `||` vs `or` — **CRÍTICO**

En Ruby hay **dos sets** de operadores lógicos con **diferente precedencia**.

| Operador         | Precedencia | Uso                            |      |                              |
| ---------------- | ----------- | ------------------------------ | ---- | ---------------------------- |
| `&&` \`          |             | ` `!\`                         | Alta | Lógica booleana, condiciones |
| `and` `or` `not` | Baja        | Control de flujo, asignaciones |      |                              |

```ruby
# ❌ TRAMPA COMÚN: and/or en condiciones
if usuario and usuario.activo?
  # Parece igual, pero la precedencia baja puede causar sorpresas
end

# ✅ Siempre en condiciones:
if usuario && usuario.activo?
  # ...
end

# ✅ Uso correcto de `or` para control de flujo (asignación con fallback)
config = cargar_configuracion or raise "Configuración no encontrada"

# ✅ Uso correcto de `and` para encadenar acciones (poco común hoy)
guardar and notificar   # equivalente a: guardar && notificar, pero con baja precedencia
```

**Regla simple**: En condiciones (`if`, `unless`, `while`, `until`), **nunca** uses `and`/`or`. Usa `&&`/`||`.

#### Asignación condicional (`||=` y `&&=`)

```ruby
# ✅ Memoization (inicializar solo si es nil/false)
def configuracion
  @configuracion ||= cargar_configuracion
end

# ✅ Solo asignar si ya tiene valor (raro pero útil)
@contador &&= @contador + 1   # Si @contador es nil, no hace nada

# ⚠️ Trampa: ||= no distingue nil de false
@visible = false
@visible ||= true   # => true  (¡sobrescribe el false!)
```

Si necesitas distinguir `nil` de `false`, usa `defined?`:

```ruby
def configuracion
  return @configuracion if defined?(@configuracion)
  @configuracion = cargar_configuracion
end
```

#### while / until -- raros en Ruby idiomático

Ruby prefiere iteradores sobre loops manuales.

```ruby
# ❌ Loop manual (C-style)
i = 0
while i < usuarios.size
  puts usuarios[i]
  i += 1
end

# ✅ Idiomático
usuarios.each { |u| puts u }

# ❌ until manual
until cola.vacia?
  procesar(cola.sacar)
end

# ✅ Mejor con loop + break (más control)
loop do
  break if cola.vacia?
  procesar(cola.sacar)
end
```

**Excepción**: `while`/`until` como modificadores de una línea son aceptables:

```ruby
numero = gets.to_i while numero <= 0   # Pide hasta que sea positivo
```

#### Asignación en condición — con cuidado

```ruby
# ⚠️ Legal pero peligroso (fácil confundir con ==)
if usuario = buscar_usuario(id)
  puts "Encontrado: #{usuario.nombre}"
end

# ✅ Mejor: separa la asignación del condicional
usuario = buscar_usuario(id)
if usuario
  puts "Encontrado: #{usuario.nombre}"
end
```

Algunos linters (RuboCop) marcan la asignación dentro de `if` como advertencia por defecto.

#### Resumen: checklist de condicionales

| Situación                             | Mejor opción                      |
| ------------------------------------- | --------------------------------- |
| 1-2 condiciones simples               | `if` / `unless` como modificador  |
| Validaciones de entrada               | Guard clauses con `return unless` |
| Múltiples valores concretos           | `case/when`                       |
| Desestructuración de datos            | `case/in` (pattern matching)      |
| Asignación condicional simple         | Operador ternario ?:              |
| Fallback si algo es nil               | `=`                               |
| Lógica booleana en `if`               | `&&` / `\|                        |
| Doble negativa o `else` con `unless`  | Cambia a `if`                     |
| Loop infinito con condición de salida | `loop { break if ... }`           |

## Estructuras de datos

#### `Array` — Lista ordenada, indexada

Usa cuando necesites orden, duplicados permitidos, o acceso por índice.

```ruby
# ✅ Buenas prácticas
usuarios = ["ana", "luis", "pedro"]

# Preferir métodos funcionales sobre loops manuales
nombres = usuarios.map(&:upcase)          # => ["ANA", "LUIS", "PEDRO"]
activos = usuarios.select { |u| u.length > 3 }  # => ["luis", "pedro"]

# each_with_index en vez de contador manual
usuarios.each_with_index { |u, i| puts "#{i}: #{u}" }

# each_with_object para acumular (más limpio que inject/reduce para hashes)
conteo = usuarios.each_with_object(Hash.new(0)) do |u, hash|
  hash[u.length] += 1
end
```

**Evita**: `for` loops (existen, pero son anti-idiomáticos en Ruby).

#### `Hash` — Diccionario / mapa

El caballo de batalla de Ruby. Usa para búsquedas por clave, configuraciones, conteos.

```ruby
# ✅ Sintaxis moderna (Ruby 3.1+)
config = { host:, port:, user: }  # Si las variables se llaman igual que las claves

# ✅ Valor por defecto seguro
# Mal: Hash.new([]) comparte el mismo array para todas las claves
# Bien:
grupos = Hash.new { |hash, key| hash[key] = [] }
grupos[:a] << 1
grupos[:b] << 2
puts grupos  # => {:a=>[1], :b=>[2]}

# ✅ fetch para claves obligatorias (falla rápido)
puerto = config.fetch(:puerto)   # KeyError si no existe, en vez de nil
```

**Regla**: Usa `Symbol` como clave para datos internos/estáticos. Usa `String` si las claves vienen del usuario, de una API, o necesitas mutarlas.

#### `Set` — Conjunto (sin duplicados, búsqueda O(1))

No viene cargado por defecto; requiere `require 'set'`.

```ruby
require 'set'

# ✅ Cuando necesites unicidad y búsquedas rápidas
tags = Set.new
tags << "ruby"
tags << "ruby"   # Ignorado, ya existe
tags.include?("ruby")  # => true (mucho más rápido que Array#include? en listas grandes)

# ✅ Intersección, unión, diferencia
a = Set[1, 2, 3]
b = Set[3, 4, 5]
a & b   # => #<Set: {3}>  (intersección)
a | b   # => #<Set: {1, 2, 3, 4, 5}>  (unión)
```

**Cuándo usar**: Si haces `array.uniq` frecuentemente o verificas `include?` en una lista grande, cámbiate a `Set`.

#### `Range` — Secuencias

Inmutable y eficiente.

```ruby
# ✅ Para rangos de números, fechas, o slicing
(1..10).to_a           # => [1, 2, 3, ..., 10]  (inclusive)
(1...10).to_a          # => [1, 2, ..., 9]      (exclusive)

# Útil para validaciones
def adolescente?(edad)
  (13..19).cover?(edad)   # Más rápido que convertir a array
end

# Slicing de arrays
letras = ('a'..'z').to_a
letras[0..4]           # => ["a", "b", "c", "d", "e"]
```

#### `Struct` vs `Data` vs `OpenStruct` — Objetos de valor ligero

| Clase        | Mutable          | Uso                                                         |
| ------------ | ---------------- | ----------------------------------------------------------- |
| `Struct`     | ✅ Sí             | Registro de datos simple, acceso por nombre                 |
| `Data`       | ❌ No (Ruby 3.2+) | Objeto de valor inmutable, con `with` para copiar           |
| `OpenStruct` | ✅ Sí             | Evítalo. Es lento, consume mucha memoria, y esconde errores |

```ruby
# ✅ Struct (para datos temporales o internos)
Punto = Struct.new(:x, :y, keyword_init: true)
p = Punto.new(x: 1, y: 2)
p.x  # => 1

# ✅ Data (inmutable, preferible en Ruby 3.2+)
Punto = Data.define(:x, :y)
p = Punto.new(1, 2)
p.with(x: 5)   # => Nuevo objeto, p sigue siendo (1, 2)

# ❌ OpenStruct (evitar en producción)
require 'ostruct'
config = OpenStruct.new(puerto: 8080)  # Lento, no usa Method Cache bien
```

#### `Queue` / `SizedQueue` — Colas thread-safe

Para concurrencia real (con Ractor o Threads).

```ruby
require 'thread'

cola = Queue.new
cola << "tarea_1"
cola << "tarea_2"

worker = Thread.new do
  while tarea = cola.pop
    puts "Procesando: #{tarea}"
  end
end
```

### Mejores prácticas generales

#### Preferir la inmutabilidad

Cuando un objeto no necesita cambiar, congélalo. Evita bugs de efectos colaterales.

```ruby
CONFIG = {
  api_url: "https://api.ejemplo.com",
  timeout: 30
}.freeze

# Si hay arrays u hashes anidados, freeze recursivo o usa deep_freeze
```

#### Usa `transform_values` / `transform_keys` en vez de iterar manualmente

```ruby
# ❌ Manual
nuevo = {}
hash.each { |k, v| nuevo[k] = v * 2 }

# ✅ Idiomático
nuevo = hash.transform_values { |v| v * 2 }
```

#### `dig` para navegar estructuras anidadas

```ruby
datos = { usuario: { direccion: { ciudad: "CDMX" } } }

# ✅ Seguro, devuelve nil si falta alguna clave
datos.dig(:usuario, :direccion, :ciudad)   # => "CDMX"
datos.dig(:usuario, :perfil, :bio)          # => nil (no rompe)
```

#### Lazy enumeration para grandes colecciones

```ruby
# ✅ No crea arrays intermedios en memoria
File.open("datos.txt")
    .lazy
    .map(&:chomp)
    .select { |l| l.start_with?("ERROR") }
    .first(10)   # Solo procesa hasta encontrar 10, no todo el archivo
```

#### `Hash#compare_by_identity` solo si sabes qué haces

Por defecto, `Hash` compara claves con `eql?` y `hash`. Si usas objetos mutables como clave, el hash se corrompe.

```ruby
# ❌ Peligroso
clave = [1, 2]
h = { clave => "valor" }
clave << 3
h[clave]   # => nil  (¡el hash interno cambió!)
```

**Regla**: Solo usa objetos inmutables (Symbol, String freezeada, Integer) como claves de Hash.

#### Memoization con cuidado

```ruby
# ✅ Simple
def configuracion
  @configuracion ||= cargar_config
end

# ✅ Con argumentos (Ruby 3+)
def datos_para(id)
  @datos_para ||= {}
  @datos_para[id] ||= fetch_datos(id)
end
```

#### No uses `Array#+` en bucles para concatenar

Crea un array nuevo en cada iteración. Usa `<<` o `concat`, o mejor aún, `flat_map`.

```ruby
# ❌ O(n²) por reconstrucción constante
resultado = []
listas.each { |lista| resultado = resultado + lista }

# ✅ O(n)
resultado = listas.flat_map { |lista| lista }
```

#### Resumen: ¿qué uso cuándo?

| Necesito...                      | Uso...                                    |
| -------------------------------- | ----------------------------------------- |
| Lista ordenada, duplicados ok    | `Array`                                   |
| Búsqueda por clave, mapeo        | `Hash`                                    |
| Unicidad, membership test rápido | `Set`                                     |
| Secuencia, rangos, validación    | `Range`                                   |
| Objeto de valor simple, mutable  | `Struct`                                  |
| Objeto de valor inmutable        | `Data` (Ruby 3.2+)                        |
| Cola entre threads               | `Queue`                                   |
| Navegar estructuras anidadas     | `dig`                                     |
| Transformar colecciones          | `map`, `select`, `flat_map`, `filter_map` |

## Metodos Ruby eficientes

#### Nombres que comunican intención

##### Reglas de convención (resumen)

| Tipo de método      | Convención          | Ejemplo                           |
| ------------------- | ------------------- | --------------------------------- |
| Acción normal       | `snake_case`        | `calcular_total`, `enviar_correo` |
| Devuelve booleano   | `predicado?`        | `activo?`, `vacio?`               |
| Versión destructiva | `bang!`             | `normalizar!`, `guardar!`         |
| Getter simple       | Nombre del atributo | `nombre`, `precio`                |
| Setter              | `nombre=`           | `self.nombre = "Ana"`             |

##### El principio: un método debe hacer **una sola cosa**

```ruby
# ❌ Mal: hace tres cosas (valida, calcula y guarda)
def procesar_orden(orden)
  if orden.items.empty?
    return false
  end
  total = orden.items.sum { |i| i.precio * i.cantidad }
  orden.update(total: total, estado: "completada")
  Notificador.enviar(orden.usuario, "Orden lista")
  true
end

# ✅ Bien: cada método tiene una responsabilidad
class Orden
  def completable?
    items.any?
  end

  def calcular_total
    items.sum { |i| i.subtotal }
  end

  def completar!
    raise OrdenVaciaError unless completable?
    update!(total: calcular_total, estado: "completada")
  end
end

class Notificador
  def self.orden_completada(orden)
    enviar(orden.usuario, "Orden lista")
  end
end
```

#### Parámetros: claridad sobre magia

Usa Keyword arguments para metodos con >1 parametro

```ruby
# ❌ Difícil de leer: ¿qué es 30 y qué es true?
crear_usuario("Ana", 30, true)

# ✅ Autodocumentado
crear_usuario(nombre: "Ana", edad: 30, activo: true)

def crear_usuario(nombre:, edad:, activo: false)
  # ...
end
```

**Excepción**: Un solo parámetro semántico puede ser posicional:

```ruby
Usuario.new("Ana")   # OK, obvio
```

**Valores por defecto seguros**

```ruby
# ❌ Peligroso: el mismo array compartido entre todas las llamadas
def agregar_tags(tags = [])
  # ...
end

# ✅ Seguro: bloque para valor por defecto fresco
def agregar_tags(tags = nil)
  tags ||= []
  # ...
end
```

**Splat y double splat con moderacion**

```ruby
# ✅ Útil para wrappers o delegación
def loggear(metodo, *args, **kwargs, &bloque)
  puts "Llamando: #{metodo}"
  send(metodo, *args, **kwargs, &bloque)
end

# ❌ Abuso: el usuario no sabe qué esperar
def crear(*args)
  # ¿args[0] es nombre? ¿edad? ¿un hash?
end
```

#### Return values: la elegancia del `return` implícito

Ruby devuelve automáticamente el valor de la última expresión. Úsalo, pero no abuses.

```ruby
# ✅ Limpio
def doble(x)
  x * 2
end

# ✅ Early return para guard clauses (legibilidad)
def dividir(a, b)
  return 0 if b.zero?
  a / b.to_f
end

# ❌ Redundante
def doble(x)
  return x * 2
end

# ❌ Múltiples returns dispersos (difícil de seguir)
def estado
  return :borrador if borrador?
  return :publicado if publicado?
  return :archivado if archivado?
  :desconocido
end

# ✅ Mejor: case expresivo
def estado
  case self
  when ->(o) { o.borrador? } then :borrador
  when ->(o) { o.publicado? } then :publicado
  when ->(o) { o.archivado? } then :archivado
  else :desconocido
  end
end
```

#### Bang methods (`!`): la convención de dos métodos

Si ofreces una versión destructiva, **siempre** ofrece la versión segura.

```ruby
class String
  def normalizar
    downcase.strip.gsub(/\s+/, " ")
  end

  def normalizar!
    replace(normalizar)
  end
end

texto = "  HOLA   MUNDO  "
texto.normalizar    # => "hola mundo" (nuevo string, texto no cambia)
texto.normalizar!   # => "hola mundo" (modifica texto in-place)
```

**Regla de oro**: El método `!` debe hacer **exactamente lo mismo** que el método sin `!`, solo que muta el receptor.

#### Métodos privados: oculta la implementación

```ruby
class ServicioDePago
  def cobrar(orden)
    validar_orden!(orden)
    transaccion = procesar_pago(orden)
    generar_recibo(transaccion)
  end

  private

  # El usuario de la clase no necesita saber que existen
  def validar_orden!(orden)
    raise OrdenInvalida unless orden.completable?
  end

  def procesar_pago(orden)
    gateway.cobrar(orden.total)
  end

  def generar_recibo(transaccion)
    Recibo.create!(transaccion: transaccion)
  end
end
```

**Nota**: En Ruby, `private` significa "no puede llamarse con receptor explícito". `protected` es raro; úsalo solo para métodos que deben ser accesibles entre instancias de la misma clase.

#### Evita side effects inesperados

Un método llamado `calcular_` no debería modificar la base de datos. Un getter no debería cambiar estado.

```ruby
# ❌ Sorpresa: un getter que modifica
def total
  @total ||= calcular_y_guardar_en_db  # ¡No!
end

# ✅ Separación de consulta y comando (CQRS simple)
def total
  @total ||= calcular
end

def guardar_total!
  update!(total: total)
end
```

#### Longitud: el método debe caber en tu pantalla

Regla práctica: si necesitas scrollear para ver todo el método, divídelo.

```ruby
# ❌ 40 líneas de lógica mezclada
def procesar_csv(archivo)
  # abrir, parsear, validar, transformar, guardar, notificar...
end

# ✅ Cadena de métodos privados descriptivos
def procesar_csv(archivo)
  datos = leer_csv(archivo)
  registros = parsear_registros(datos)
  validar_registros!(registros)
  importar_registros(registros)
  notificar_importacion(registros.count)
end
```

#### Duck typing: confía en el comportamiento, no en el tipo

No verifiques clases con `is_a?` a menos que sea estrictamente necesario.

```ruby
# ❌ Rígido y frágil
def notificar(usuario)
  if usuario.is_a?(UsuarioEmail)
    enviar_email(usuario.correo)
  elsif usuario.is_a?(UsuarioSms)
    enviar_sms(usuario.telefono)
  end
end

# ✅ Duck typing: si responde a `direccion` y `notificar`, funciona
def notificar(destinatario)
  destinatario.notificar(mensaje)
end

# Las clases solo necesitan implementar la interfaz
class UsuarioEmail
  def notificar(mensaje)
    Mailer.enviar(direccion, mensaje)
  end

  def direccion
    correo
  end
end
```

#### Bloques: pasarlos con elegancia

```ruby
# ✅ Yield (más eficiente, no crea objeto Proc)
def con_temporizador
  inicio = Time.now
  yield
  Time.now - inicio
end

# ✅ &block solo si necesitas el objeto (para pasarlo a otro método)
def delegar(&block)
  otro_objeto.ejecutar(&block)
end

# ✅ block_given? para comportamiento condicional
def configurar
  yield self if block_given?
  self
end

# Uso fluido:
configurar do |c|
  c.host = "localhost"
  c.puerto = 3000
end
```

#### Documentación con YARD (opcional pero profesional)

```ruby
# Calcula el precio final aplicando impuestos y descuentos.
#
# @param base [BigDecimal] Precio sin modificaciones.
# @param descuento [BigDecimal] Porcentaje de descuento (0.0 a 1.0).
# @param impuesto [BigDecimal] Porcentaje de impuesto (0.0 a 1.0).
# @return [BigDecimal] Precio final redondeado a 2 decimales.
# @raise [ArgumentError] Si base es negativo.
def precio_final(base:, descuento: 0, impuesto: 0.16)
  raise ArgumentError, "Base negativa" if base.negative?
  (base * (1 - descuento) * (1 + impuesto)).round(2)
end
```

### Resumen: checklist para cada método

| Pregunta                         | Buena práctica                                       |
| -------------------------------- | ---------------------------------------------------- |
| ¿Hace más de una cosa?           | Divídelo en métodos privados.                        |
| ¿Tiene más de 3-4 parámetros?    | Usa keyword arguments.                               |
| ¿Modifica el objeto?             | Ofrece versión sin `!` y con `!`.                    |
| ¿Devuelve booleano?              | Termina en `?`.                                      |
| ¿Tiene side effects ocultos?     | Separa consulta de comando.                          |
| ¿Revisa tipos con `is_a?`?       | Usa duck typing o `respond_to?`.                     |
| ¿Necesita scrollear para leerlo? | Extrae lógica a métodos privados.                    |
| ¿El nombre es un verbo ambiguo?  | Usa `calcular_`, `obtener_`, `generar_`, `validar_`. |

## Manejo de Excepciones

Estructura básica: `begin / rescue / else / ensure`

```ruby
begin
  # Código que puede fallar
  resultado = 10 / divisor
rescue ZeroDivisionError => e
  # Solo captura este error específico
  puts "No se puede dividir por cero: #{e.message}"
  resultado = 0
rescue TypeError => e
  # Otro error específico
  puts "Tipo incorrecto: #{e.message}"
else
  # Solo se ejecuta si NO hubo excepción
  puts "División exitosa: #{resultado}"
ensure
  # Siempre se ejecuta (limpieza, cerrar archivos, etc.)
  puts "Operación finalizada"
end
```

### Buenas practicas:

#### Buena práctica 1: **Rescata excepciones específicas, nunca `rescue Exception`**

```ruby
# ❌ MUY PELIGROSO: captura TODO, incluyendo SyntaxError, SignalException, etc.
begin
  # código
rescue Exception => e
  puts "Error: #{e}"
end

# ✅ Captura solo lo que esperas
begin
  File.read("config.json")
rescue Errno::ENOENT => e
  puts "Archivo no encontrado: #{e.message}"
rescue JSON::ParserError => e
  puts "JSON inválido: #{e.message}"
end
```

**Regla**: Si no sabes qué excepción esperas, **no la captures**. Deja que suba y te informe el bug real.

#### Buena práctica 2: **Rescata lo más cerca posible del fallo**

```ruby
# ❌ Rescata un bloque enorme, oculta dónde falló
begin
  cargar_configuracion
  conectar_base_de_datos
  iniciar_servidor
  procesar_peticiones
rescue => e
  puts "Algo falló: #{e}"
end

# ✅ Cada operación crítica rescata su propio riesgo
def iniciar_sistema
  configuracion = cargar_configuracion
rescue Errno::ENOENT
  usar_configuracion_por_defecto
end

def iniciar_sistema
  conectar_base_de_datos
rescue PG::ConnectionBad
  reintentar_conexion
end
```

#### Buena práctica 3: **Usa `raise` para fallar rápido y con contexto**

```ruby
# ❌ Error genérico, difícil de debuggear
def procesar_orden(orden)
  raise "Error" if orden.nil?
end

# ✅ Error específico con contexto
def procesar_orden(orden)
  raise ArgumentError, "La orden no puede ser nil" if orden.nil?
  raise OrdenVaciaError, "La orden #{orden.id} no tiene items" if orden.items.empty?
end

# ✅ Re-lanzar con contexto adicional (encadenamiento)
begin
  gateway.cobrar(tarjeta)
rescue GatewayError => e
  raise PagoFallidoError, "Pago rechazado para orden #{orden.id}: #{e.message}"
end
```

**Tip**: Define tus propias excepciones heredando de `StandardError`:

```ruby
class ErrorDeNegocio < StandardError; end
class OrdenVaciaError < ErrorDeNegocio; end
class PagoFallidoError < ErrorDeNegocio; end
class UsuarioNoAutorizadoError < ErrorDeNegocio; end
```

#### Buena práctica 4: **`ensure` para limpieza garantizada**

```ruby
# ✅ Patrón clásico: archivo siempre se cierra
def leer_archivo(ruta)
  archivo = File.open(ruta, "r")
  archivo.read
rescue Errno::ENOENT
  "Archivo no existe"
ensure
  archivo&.close   # & para no romper si archivo es nil
end

# ✅ Equivalente moderno con bloque (mejor, maneja ensure implícito)
def leer_archivo(ruta)
  File.read(ruta)
rescue Errno::ENOENT
  "Archivo no existe"
end
```

#### Buena práctica 5: **No uses excepciones para control de flujo normal**

```ruby
# ❌ Abuso: excepción como "return especial"
begin
  usuario = Usuario.find(id)
rescue ActiveRecord::RecordNotFound
  return nil
end

# ✅ Mejor: métodos que no lanzan excepciones para casos esperados
usuario = Usuario.find_by(id: id)   # Devuelve nil si no existe
return nil unless usuario
```

**Regla de oro**: Las excepciones son para **situaciones excepcionales**, no para lógica de negocio rutinaria.

#### Buena práctica 6: **`retry` con límite de intentos**

```ruby
def conectar_con_reintentos(max_intentos: 3)
  intentos = 0

  begin
    intentos += 1
    conectar_a_servidor
  rescue Timeout::Error => e
    if intentos < max_intentos
      sleep(2 ** intentos)   # Backoff exponencial
      retry
    else
      raise ConexionFallidaError, "Falló después de #{max_intentos} intentos"
    end
  end
end
```

### Patrón Null Object

#### El problema: condicionales de `nil` por todos lados.

```ruby
# ❌ Código defensivo repetitivo
def mostrar_saludo(usuario)
  if usuario
    nombre = usuario.nombre
  else
    nombre = "Invitado"
  end
  puts "Hola, #{nombre}"
end

# ❌ Peor: navegación defensiva
ciudad = usuario&.direccion&.ciudad || "Desconocida"
```

#### La solución: un objeto que responde a todo pero hace "nada útil"

```ruby
# 1. Define la interfaz del objeto real
class Usuario
  attr_reader :nombre, :email, :direccion

  def initialize(nombre, email, direccion)
    @nombre = nombre
    @email = email
    @direccion = direccion
  end

  def saludar
    "Hola, #{nombre}"
  end

  def premium?
    false
  end
end

# 2. Crea el Null Object con la MISMA interfaz
class UsuarioInvitado
  def nombre
    "Invitado"
  end

  def email
    ""
  end

  def direccion
    DireccionNula.new
  end

  def saludar
    "Bienvenido, invitado"
  end

  def premium?
    false
  end
end

class DireccionNula
  def ciudad
    "Desconocida"
  end

  def pais
    "Desconocido"
  end
end
```

#### Uso: nunca más condicionales de `nil`

```ruby
# ✅ El código fluye sin preguntar "¿existe?"
def mostrar_saludo(usuario)
  puts usuario.saludar
end

# Funciona con un usuario real
mostrar_saludo(Usuario.new("Ana", "ana@ej.com", nil))
# => "Hola, Ana"

# Funciona con el null object
mostrar_saludo(UsuarioInvitado.new)
# => "Bienvenido, invitado"

# Navegación segura sin &
ciudad = usuario.direccion.ciudad   # Siempre funciona, nunca nil
```

#### Versión con Singleton (más eficiente)

```ruby
class UsuarioInvitado
  include Singleton   # Solo existe una instancia en toda la app

  def nombre; "Invitado"; end
  def email; ""; end
  def saludar; "Bienvenido, invitado"; end
  def premium?; false; end
  def direccion; DireccionNula.instance; end
end

# Uso
usuario = buscar_usuario(id) || UsuarioInvitado.instance
```

#### Null Object en Rails/ActiveRecord

```ruby
# En el modelo
class Usuario < ApplicationRecord
  def self.con_id(id)
    find_by(id: id) || UsuarioInvitado.new
  end
end

# En el controlador
def show
  @usuario = Usuario.con_id(params[:id])  # Nunca nil
end

# En la vista (sin condicionales)
<%= @usuario.saludar %>
<%= @usuario.direccion.ciudad %>
```

#### ¿Cuándo NO usar Null Object?

| ❌ No usar                                                            | ✅ Usar en su lugar            |
| -------------------------------------------------------------------- | ----------------------------- |
| Cuando `nil` tiene significado de negocio distinto                   | `nil` explícito + condicional |
| Cuando el null object haría cosas peligrosas (guardar en DB, cobrar) | Excepción o validación previa |
| APIs públicas donde el cliente espera `nil`                          | Documentar y mantener `nil`   |

#### Comparativa: antes vs. después

| Situación | Sin Null Object                         | Con Null Object            |
| --------- | --------------------------------------- | -------------------------- |
| Saludo    | `usuario ? usuario.nombre : "Invitado"` | `usuario.nombre`           |
| Dirección | `usuario&.direccion&.ciudad`            | `usuario.direccion.ciudad` |
| Precio    | `producto ? producto.precio : 0`        | `producto.precio`          |
| Permisos  | `usuario && usuario.admin?`             | `usuario.admin?`           |

### Resumen

| Excepciones                                | Null Object                                         |
| ------------------------------------------ | --------------------------------------------------- |
| Rescata **específicas**, nunca `Exception` | Implementa la **misma interfaz** que el objeto real |
| Usa `ensure` para limpieza                 | Nunca devuelve `nil`                                |
| No uses excepciones para flujo normal      | Usa `Singleton` si el null object no tiene estado   |
| Define tu jerarquía de errores de negocio  | No lo uses cuando `nil` tiene significado diferente |
| `retry` solo con límite de intentos        | Elimina `&.` y condicionales defensivos             |
