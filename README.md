QuickFix TradeClient Web User Interface
-------------------------------------------

Quickfix trade client

The trade client subscribes to RabbitMQ and executes orders received.

The trade client is based on the one from https://github.com/quickfixgo/examples


Installation
~~~~~~~~~~~~

```
go get github.com/streadway/amqp
make install
```

Usage
~~~~~

```
make run_tradeclient
```

Other
~~~~~

RabbitMQ server running on localhost:5672 (standard port)

(The RabbitMQ server scripts are installed into /usr/local/sbin. This is not automatically added to your path, so you may wish to add
PATH=$PATH:/usr/local/sbin to your .bash_profile or .profile. The server can then be started with rabbitmq-server.)

The tradeclient receives messages from the RabbitMQ server and translates using FIX messages protocols.
