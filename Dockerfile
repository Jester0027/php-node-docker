FROM php:8.0.1-fpm

### Installing php extensions and packages
RUN apt-get update && apt-get install -y \
    ####    ####
    # Packages #
    ####    ####
        git \
        libzip-dev \
        zlib1g-dev \
        libxml2 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libicu-dev \
    && docker-php-ext-install \
    ####          ####
    # PHP extensions #
    ####          ####
        zip \
        intl \
        pdo \
        pdo_mysql \
        mysqli \
        opcache

### Installing Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

### Installing Xdebug and APCu
RUN docker-php-source extract \
    && pecl install xdebug apcu \
    && docker-php-ext-enable xdebug apcu \
    && docker-php-source delete
#RUN mkdir -p /usr/src/php/ext/apcu && curl -fsSL https://pecl.php.net/get/apcu | tar xvz -C "/usr/src/php/ext/apcu" --strip 1 \
#    && mkdir -p /usr/src/php/ext/xdebug && curl -fsSL https://pecl.php.net/get/xdebug | tar xvz -C "/usr/src/php/ext/xdebug" --strip 1 \
#    && docker-php-ext-install apcu xdebug

### Installing nodejs
ENV NODE_VERSION=12.6.0
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

### Installing yarn
RUN npm i -g yarn \
    && yarn -v

RUN rm -rf /var/lib/apt/lists/*