#!/bin/bash

if ! command -v docker &> /dev/null; then
    echo "Docker не установлен. Установите Docker перед запуском этого скрипта."
    exit 1
fi

# Функция для форматирования времени работы контейнера
format_uptime() {
    local uptime_seconds="$1"
    local uptime_formatted

    ((days = uptime_seconds / 86400))
    ((hours = (uptime_seconds % 86400) / 3600))
    ((minutes = (uptime_seconds % 3600) / 60))
    ((seconds = uptime_seconds % 60))

    uptime_formatted=""
    if ((days > 0)); then
        uptime_formatted="${days}д "
    fi
    if ((hours > 0)); then
        uptime_formatted="${uptime_formatted}${hours}ч "
    fi
    if ((minutes > 0)); then
        uptime_formatted="${uptime_formatted}${minutes}м "
    fi
    uptime_formatted="${uptime_formatted}${seconds}с"

    echo "$uptime_formatted"
}

echo -e "Все контейнеры Docker:"
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Size}}\t{{.ID}}" | tail -n +2

echo -e "\nПоднятые сервисы Docker:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Size}}\t{{.RunningFor}}\t{{.ID}}" | tail -n +2

echo -e "\nНе поднятые сервисы Docker:"
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Size}}\t{{.ID}}" | awk '$2 == "Exited" {print $0}' | tail -n +2

# Получаем информацию о контейнерах, которые не использовались в течение 25 дней
OLD_CONTAINERS=$(docker ps -a --format "{{.Names}}\t{{.Status}}\t{{.ID}}" | awk -v cutoff=$(date -d 'now - 25 days' '+%Y-%m-%d') '$2 < cutoff {print $1}')
if [ -n "$OLD_CONTAINERS" ]; then
    echo -e "\nРекомендация: Вы давно не использовали следующие контейнеры. Рекомендуется их выключить:"
    echo -e "Имя контейнера\tСтатус\tID контейнера"
    echo -e "$OLD_CONTAINERS"
fi
