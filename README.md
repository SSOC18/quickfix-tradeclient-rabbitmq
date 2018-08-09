QuickFix TradeClient + RabbitMQ
-------------------------------------------

The quickfix tradeclient subscribes to RabbitMQ server and executes orders received.


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


Sample Message
--------------

The trade client is based on the one from https://github.com/quickfixgo/examples. 

Instead of receiving an order from the user input on the command line (as the original repository), our tradeclient receives string messages from the RabbitMQ server and parses it into several variables. Each variable are the inputs that are translated to conform to FIX messages protocols.  Finally, it sends each component to an executor.

The order format is defined in golang as follows:

```
type OrderDetails struct{

  	Action [string]: 1 (NEW ORDER) / 2 (CANCEL ORDER) / 3 (MARKET DATA REQUEST) / 4 (QUIT)
  	Version [string]: 1 (FIX4.0) / 2 (FIX4.1) / ... / 5 (FIX4.4) / 6 (FIX1.1)
	ClOrdId [string]
	Price [string]
	Symbol [string]
	OrderQty [string]
	Side [string]: 1 (Buy) / 2 (Sell) / 3 (Sell Short) / 4 (Sell Short Exempt) / 5 (Cross) / 6 (Cross Short) / 7 (Cross Short Exempt)
	OrdType [string]: 1 (Market) / 2 (Limit) / 3 (Stop) / 4 (Stop Limit)
	TimeInForce [string]: 1 (Day) / 2 (IOC) / 3 (OPG) / 4 (GTC) / 5 (GTX)
	SenderCompID [string]
	TargetCompID [string]
	TargetSubID [string]: y or n

	}
```


A sample example message compatible with our tradeclient is shown below, with all variables as strings (including the brackets) sent from the RabbitMQ server:

```
{1 3 mickmek 6752 BTCUSD 99 2 2 1 TW ISLD n}
```

This would be translated by our tradeclient as:

```
Action=NewOrder ; Version=FIX4.2 ; ClordId=mickmek ; Price=6752 ; Symbol=BTCUSD ; OrdQty=99 ; Side=Sell ; OrdType=Limit ; TimeInForce=Day ; SenderID=TW ; TargetID=ISLD ; TargetSubID=n
```

Example
-------
Using Management Command Line Tools to send messages through RabbitMQ
(See https://www.rabbitmq.com/management-cli.html)

Make sure rabbitmq is installed with the proper path (`PATH=$PATH/usr/local/sbin`) and run the rabbitmq server (`rabbitmq-server`)
Run the tradeclient, then run the following commands in the terminal:

```
>>>PATH=$PATH:/usr/local/sbin

>>>rabbitmqadmin publish routing_key=orders payload="{1 3 mickmek 6752 BTCUSD 99 2 2 1 TW ISLD n}"
```

A confirmation message:`Message published` will be printed on the terminal. Upon receiving the message, our tradeclient will print out the following:

```
  [*] Waiting for messages. To exit press CTRL+C
 Received a message: {1 3 mickmek 6752 BTCUSD 99 2 2 1 TW ISLD n}
Version: FIX 4.2
ClOrdID: mickmek
Symbol: BTCUSD
Side: Sell
OrderType: Limit
OrderQty: 99
Price: 6752
TimeInForce: Day
SenderCompID: TW
TargetCompID: ISLD
TargetSubID: n
Sending 8=FIX.4.29=14035=D34=149=TW52=20180809-15:08:59.82156=ISLD57=n11=mickmek21=138=99.0040=244=6752.0054=255=BTCUSD59=060=20180809-15:08:59.82110=245
```
(NOTE: In this example, no executor is present to receive the order from the tradeclient)



Other useful commands:

To list available exchanges:
`rabbitmqadmin -V test list exchanges`

To list details of available queues:
`rabbitmqadmin -f long -d 3 list queues`

See other commands:
```
rabbitmqadmin --bash-completion
rabbitmqadmin --help
rabbitmqadmin help subcommands
```
