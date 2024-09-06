module ProductsHelper
  def featured_image(product, classes: "w-full aspect-video rounded-md my-0")
    if (url = featured_image_url(product))
      image_tag(url, class: classes)
    else
      tag.div class: class_names("placeholder-image", classes)
    end
  end

  def featured_image_url(product)
    if product&.featured_image_url?
      product.featured_image_url
    elsif product&.featured_image&.attached?
      product.featured_image.url
    end
  end

  def pricing(product)
    return if product.amount_in_cents.blank?
    amount = number_to_currency(product.amount_in_cents / 100.0)
    if product.interval?
      interval = product.interval_count == 1 ? product.interval : pluralize(product.interval_count, product.interval)
      amount += " / #{interval}"
    end
    amount
  end
end
