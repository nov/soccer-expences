module CurrencyHelper
  def as_currency(amount, unit: '¥', precision: 0)
    formatted_amount = number_to_currency amount, unit: unit, precision: precision
    if amount < 0
      content_tag :span, class: 'text-danger' do
        formatted_amount
      end
    else
      formatted_amount
    end
  end
end