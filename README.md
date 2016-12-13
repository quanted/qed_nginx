# qed_nginx

This repo contains the NGINX conf used for HTTPS/SSL. Adding SSL to the web server requires additional steps which are detailed here. 

## nginx.conf

The NGINX configuration file needs SSL directives added to it as well as telling the server to listen on port 443. 
The added directives all begin with "ssl". The notable directives are ```ssl_certificate``` and ```ssl_certificate_key```.
Both of these must point to valid signed SSL certificates located on the server (or Docker container in this case). Additionally, 
Chrome requires additional information to be included in the SSL cert, called "SSL certificate chains". 
## SSL Certificates

In NGINX's case, this requires concatenating the chain certificate to the star certificate:

    $ sudo mkdir -p /var/www/nginx/certs
    $ cat star_epa_gov.crt DigiCertCA.crt > /var/www/nginx/certs/qed.epa.gov.chained.crt

The private key sent in with the SSL cert requests also needs to be on server:

    $ /var/www/nginx/certs/qed.key

After putting the certificates on the server (e.g. SFTP) tighten down the permissions on the directory and certificates

    $ sudo chown -R root:root /var/www/nginx/certs
    $ sudo chmod -R 600 /var/www/nginx/certs

# References

## [NGINX HTTP->HTTPS Redirect](http://serverfault.com/a/337893)

## [NGINX SSL Config](https://www.bentasker.co.uk/documentation/linux/217-centos-using-nginx-as-an-ssl-reverse-proxy-for-apache)

## [Chained Certificates](http://nginx.org/en/docs/http/configuring_https_servers.html#chains)

## [NGINX SSL Setup Tutorial](http://blog.chrismeller.com/creating-and-managing-ssl-certificates-with-nginx)

## [QED Taiga WIKI Links](https://tree.taiga.io/project/puruckertom-qed/wiki/server-config)