const app = require('./app');


async function main(){
    await app.listen(4000);
    console.log('Server started on port 4000');
}

main();