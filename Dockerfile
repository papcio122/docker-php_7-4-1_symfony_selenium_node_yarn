FROM php:7.4.1

RUN apt-get update -yqq
RUN apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev unzip
RUN apt-get install -yqq libzip-dev apt-utils
RUN apt-get install -yqq libonig-dev
RUN docker-php-ext-install gmp bcmath zip pdo_mysql mbstring curl json intl gd xml bz2 opcache
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN curl -sS https://getcomposer.org/installer | php
RUN chmod +x composer.phar
RUN mv /composer.phar /usr/bin/composer.phar
RUN ln /usr/bin/composer.phar /usr/bin/composer
RUN apt-get install -yqq python
RUN adduser --disabled-password -gecos "" application
RUN su - application -c "composer global require hirak/prestissimo"

RUN mkdir -p /usr/share/man/man1 # workaround for error
RUN apt-get update
RUN apt-get install -y openjdk-11-jdk-headless screen maven xvfb
RUN apt-get install -y firefox-esr
RUN apt-get install -y wget
RUN cd /root && wget https://chromedriver.storage.googleapis.com/78.0.3904.105/chromedriver_linux64.zip
RUN cd /root && unzip chromedriver_linux64.zip
RUN cp /root/chromedriver /bin/
RUN cd /root && wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz
RUN cd /root && tar -zxvf geckodriver-v0.24.0-linux64.tar.gz
RUN cp /root/geckodriver /bin/
RUN cd /root && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y fonts-liberation libappindicator3-1 lsb-release libxss1 xdg-utils libgbm1
RUN cd /root && dpkg -i google-chrome-stable_current_amd64.deb
RUN rm -rfv /root/*
RUN chmod 755 /bin/chromedriver
RUN echo 'en_GB.UTF-8 UTF-8' >> /etc/locale.gen
RUN apt-get install -y locales
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN locale-gen en_GB.UTF-8
RUN update-locale LANG=en_GB.utf8
RUN echo 'export LC_ALL=en_GB.UTF-8' >> /etc/profile
RUN echo 'export LANG=en_GB.UTF-8' >> /etc/profile
RUN echo 'export LANGUAGE=en_GB.UTF-8' >> /etc/profile

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install nodejs -y
RUN apt-get install -y mariadb-client
RUN docker-php-ext-install mysqli

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install yarn -y
RUN wget https://get.symfony.com/cli/installer -O - | bash
