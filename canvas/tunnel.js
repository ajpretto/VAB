const localtunnel = require('localtunnel');

(async () => {
  const tunnel = await localtunnel({ 
    port: 18800, 
    subdomain: 'anthony-mc'
  });

  console.log('Mission Control Public URL:', tunnel.url);

  tunnel.on('close', () => {
    console.log('Tunnel closed, restarting...');
    process.exit(1); // PM2 will restart
  });

  tunnel.on('error', (err) => {
    console.error('Tunnel error:', err);
    process.exit(1);
  });
})();
