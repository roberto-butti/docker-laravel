FROM robertobutti/php-8.0-apache:php8.0.0

RUN apt-get clean
RUN apt-get update


RUN apt-get install -y \
    libzip-dev \
    zip \
    libpng-dev

RUN docker-php-ext-install zip pdo_mysql bcmath gd

RUN rm -rf /var/lib/apt/lists/*

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
    mv composer.phar /usr/local/bin/composer

RUN rm /etc/apache2/sites-available/000-default.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf

RUN ls /etc/apache2/sites-available/
ADD ./config/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN cat /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# RUN service apache2 restart
RUN ln -s /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf