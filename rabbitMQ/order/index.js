const express = require('express');
const amqp = require('amqplib');
const app = express();
app.use(express.json());

async function connectRabbitMQ() {
    const connection = await amqp.connect('amqp://localhost');
    const channel = await connection.createChannel();
    await channel.assertQueue('paymentQueue');
    return channel;
}
let rUrl = "amqp://myuser:mypassword@localhost:5672/"

async function receiveOrder() {
    const connection = await amqp.connect(rUrl);
    // const connection = await amqp.connect('amqp://localhost');
    const channel = await connection.createChannel();
    await channel.assertQueue('orderQueue');

    channel.consume('orderQueue', async (msg) => {
        const respo = JSON.parse(msg.content.toString())
        console.log('Received order:', respo);
        const order = "I have received this call. Thanks!";

        // Forward order to payment service
        await channel.sendToQueue('paymentQueue', Buffer.from(JSON.stringify(order)));
    }, { noAck: true });
}

app.get('/order', (req, res) => {
    res.send('Order Service');
});

receiveOrder();

app.listen(3001, () => console.log('Order Service running on port 3001'));
