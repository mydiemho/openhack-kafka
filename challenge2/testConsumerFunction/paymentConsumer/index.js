module.exports = async function (context, paymentMessages) {
    context.log(`JavaScript eventhub trigger function called for message array ${paymentMessages}`);
    
    paymentMessages.forEach((message, index) => {
        context.log(`Processed message ${message}`);
        for(var key in message) {
            console.log(`key ${key}\nvalue ${message[key]}\n`);
            console.log("================");
        }
    });
};