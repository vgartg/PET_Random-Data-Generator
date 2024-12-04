# Random Data Generator

### Это задание Горбанёва Валерия по CS212(Ruby)
### Тема утверждена Горшковым Сергеем Андреевичем
Random Data Generator - это библиотека на Ruby для генерации случайных данных различных типов, таких как строки, числа, даты и многое другое

## Установка

Вы можете установить библиотеку, используя Bundler:

```bash
gem 'random-data-generator'
```

или установите ее напрямую с помощью gem install:

```bash
gem install random-data-generator
```

## Использование
Пример использования библиотеки:

```ruby
require 'random_data_generator'
```

### Генерация случайной строки длиной 10 символов
```
puts RandomDataGenerator.random_string(10)
```

### Генерация случайного числа в диапазоне от 1 до 100
```
puts RandomDataGenerator.random_number(1, 100)
```

### Генерация случайной даты в диапазоне с 1 января 2020 по 31 декабря 2025
```
puts RandomDataGenerator.random_date(Date.new(2020, 1, 1), Date.new(2025, 12, 31))
```

# Дополнительные методы
## Библиотека также предоставляет дополнительные методы для генерации случайных данных:

```RandomDataGenerator.random_alpha_numeric_string(length)``` генерирует случайную алфавитно-цифровую строку заданной длины

```RandomDataGenerator.random_letter_string(length)``` генерирует случайную строку буквенных символов заданной длины

```RandomDataGenerator.random_ip_address``` генерирует случайный IP-адрес

```RandomDataGenerator.random_email``` генерирует случайный адрес электронной почты

## Тесты и rubocop
<a href="https://imgbb.com/"><img src="https://i.ibb.co/PYzSf6w/photo-2024-04-23-21-31-03.jpg" alt="photo-2024-04-23-21-31-03" border="0"></a>
