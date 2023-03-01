# Класс, представляющий интерфейс состояния
class OrderState
    def next_state
        raise NotImplementedError, 'Метод должен быть определен в подклассе'
    end

    def cancel
        raise NotImplementedError, 'Метод должен быть определен в подклассе'
    end

    def ship
        raise NotImplementedError, 'Метод должен быть определен в подклассе'
    end
end

# Состояние "Новый заказ"
class NewOrderState < OrderState
    def next_state
        ProcessingOrderState.new
    end

    def cancel
        puts 'Заказ был отменен'
    end

    def ship
        raise 'Заказ не может быть отправлен, пока не обработан'
    end
end

# Состояние "Обработка заказа"
class ProcessingOrderState < OrderState
    def next_state
        ShippedOrderState.new
    end

    def cancel
        puts 'Заказ был отменен'
    end

    def ship
        puts 'Заказ отправлен'
    end
end

# Состояние "Заказ отправлен"
class ShippedOrderState < OrderState
    def next_state
        raise 'Заказ уже отправлен'
    end

    def cancel
        raise 'Невозможно отменить отправленный заказ'
    end

    def ship
        raise 'Заказ уже отправлен'
    end
end

# Класс, управляющий заказом
class Order
    def initialize
        @state = NewOrderState.new
    end

    def next_state
        @state = @state.next_state
    end

    def cancel
        @state.cancel
    end

    def ship
        @state.ship
        next_state
    end
end

# Использование
order = Order.new


order.next_state
order.ship
order.cancel
