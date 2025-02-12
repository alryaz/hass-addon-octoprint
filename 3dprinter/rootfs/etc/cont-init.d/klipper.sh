#!/usr/bin/with-contenv bashio

bashio::log.info "Klipper cont-init.d"

if bashio::config.true 'klipper'; then
    # Copy Klipper install to persistent storage, if missing.
    if [ ! -d /data/python/klipper ]; then
        if [ -f /root/klipper-python.tar.gz ]; then
            tar -zxf /root/klipper-python.tar.gz -C /data
            bashio::log.notice "Klipper Python extracted"
        else
            bashio::log.warning "Klipper Python not found"
        fi
    fi

    # Copy source to persistent storage, if missing.
    if [ ! -d /data/src/klipper ]; then
        if [ -f /root/klipper-src.tar.gz ]; then
            tar -zxf /root/klipper-src.tar.gz -C /data
            bashio::log.notice "Klipper src extracted"
        else
            bashio::log.warning "Klipper src not found"
        fi
    fi

    # Copy config to persistent storage, if missing.
    if [ ! -f /data/config/klipper/printer.cfg ]; then
        if [ -f /root/config/klipper/printer.cfg ]; then
            mkdir -p /data/config/klipper
            cp /root/config/klipper/printer.cfg /data/config/klipper/printer.cfg
            bashio::log.notice "Default Klipper config copied"
        else
            bashio::log.warning "Default Klipper config not found"
        fi
    fi

    # Make sure log file exists
    touch /tmp/klippy.log

    # Configure autostart of service
    rm -f /etc/services.d/klipper/down
    rm -f /etc/services.d/klipper/finish
else
    bashio::log.notice "Klipper disabled"
fi
