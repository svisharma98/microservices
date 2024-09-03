const express = require('express');
const amqp = require('amqplib');
const app = express();
app.use(express.json());

let rUrl = "amqp://myuser:mypassword@localhost:5672/"

async function receivePayment() {
    // const connection = await amqp.connect('amqp://localhost');
    const connection = await amqp.connect(rUrl);
    const channel = await connection.createChannel();
    await channel.assertQueue('paymentQueue');

    channel.consume('paymentQueue', (msg) => {
        const payment = JSON.parse(msg.content.toString());
        console.log('Processing payment for order:', payment);
        // Simulate payment processing...
    }, { noAck: true });
}

app.get('/payment', (req, res) => {
    res.send('Payment Service');
});

receivePayment();

app.listen(3002, () => console.log('Payment Service running on port 3002'));
