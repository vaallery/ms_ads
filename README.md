# Установка и запуск приложения
```
  git clone https://github.com/vallery/ms_ads.git
```
## Создать пользователя и базы данных
```
  createuser -U postgres ads
  createdb -U postgres -O ads ads_production
  createdb -U postgres -O ads ads_test
  createdb -U postgres -O ads ads_development
```

## Смигрировать базы

```
  cd ms_ads
  rake dev_up  # Migrate the development database up
  rake test_up # Migrate the test database up
  rake prod_up # Migrate the production database up
```
## Используемые библиотеки

- roda :: web framework
- sequel :: database library
- rack-unreloader :: development code reloader

## Переменные окружения

- ADS_DATABASE_URL :: database connection URL to give to Sequel, default is to
                       create one based on the application's name and RACK_ENV.
- ADS_SESSION_SECRET :: cookie session secret, must be >=64 bytes
- RACK_ENV :: environment to use (production, development, or test), defaults
            to development.

## Запуск приложения
```shell
rackup
```
  
# ms_ads
