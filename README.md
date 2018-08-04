QuickFix TradeClient Web User Interface
-------------------------------------------

Quickfix trade client

The trade client subscribes to RabbitMQ and executes orders received.

The trade client is based on the one from https://github.com/quickfixgo/examples.
Our tradeclient receives messages from the RabbitMQ server and translates using FIX messages protocols, instead of receiving an order from the user input on the command line and then forwarded it to the executor (as the original repository).
In order to achieve that, our tradeclient receives a string message containing all required information for a new order. It parses the message to separate its component, and constitutes new variables (with the proper FIX messaging protocol). Finally, it sends each component to an executor.


Installation
------------

```
go get github.com/streadway/amqp
make install
```

Usage
-----

```
make run_tradeclient
```


Example
-------





