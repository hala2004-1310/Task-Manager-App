# استخدام صورة PHP 8.3 الرسمية
FROM php:8.3-fpm

# تثبيت الأدوات اللازمة للنظام
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# تنظيف الكاش
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# تثبيت Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# تحديد مجلد العمل داخل الحاوية ليكون مجلد لارافل مباشرة
WORKDIR /var/www/laravel

# نسخ ملفات المشروع بالكامل
COPY laravel/ .

# تثبيت الاعتماديات الخاصة بـ Laravel
RUN composer install --no-interaction --optimize-autoloader --no-dev --no-scripts

# ضبط الصلاحيات للمجلدات الحساسة داخل مجلد لارافل
RUN chown -R www-data:www-data /var/www/laravel/storage /var/www/laravel/bootstrap/cache

# فتح المنفذ وتشغيل الخادم
EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]