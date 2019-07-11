# email-notifier
Stand-alone email service that consumes messages from kafka topic, produced by the central-notifications service.
The central-notificattions repo is available [here](https://github.com/mojaloop/central-notifications/tree/master)
The email-notifier flow is available [here](https://github.com/mojaloop/central-notifications/tree/master#Notifierflowseparateservice)

## Mac OS installation problems

If you have this or similar error during installation:

```
npm install
> node-gyp rebuild
clang: error: linker command failed with exit code 1
```

add the following environmental variables: 
```
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib
```

## Config

Whole config is located [here](config/default.json)

The email settings are: 

```
  "emailSettings": {
    "smtpConfig": {
      "host": "smtp.gmail.com",
      "port": 587,
      "secureConnection": false,
      "tls": {
        "ciphers":"SSLv3"
     },
      "auth": {
        "user": "modusboxnotifier@gmail.com",
        "pass": "m0dusb0xn0t1f13r"
      }
    }
  }
```

Those can be passed as the following environment variables: 

```
{
  "emailSettings": {
    "smtpConfig": {
      "host": "MAIL_NOTIF_SMTP_HOST",
      "port": "MAIL_NOTIF_SMTP_PORT",
      "secureConnection": "MAIL_NOTIF_SMTP_SECURE_FLAG",
      "tls": {
        "ciphers":"MAIL_NOTIF_SMTP_TLS_CIPHERS"
     },
      "auth": {
        "user": "MAIL_NOTIF_SMTP_USER",
        "pass": "MAIL_NOTIF_SMTP_PASS"
      }
    }
  }

}  ```
