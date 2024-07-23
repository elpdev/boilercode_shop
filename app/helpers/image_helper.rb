module ImageHelper
  def logo(class: "h-6")
    if SellRepo.config.logo_url?
      image_tag(SellRepo.config.logo_url, class: "h-6", alt: SellRepo.store_name)
    elsif SellRepo.config.logo.attached?
      image_tag(SellRepo.config.logo, class: "h-6", alt: SellRepo.store_name)
    else
      SellRepo.store_name
    end
  end

  def opengraph_image_url
    if SellRepo.config.opengraph_image_url?
      SellRepo.config.opengraph_image_url
    elsif SellRepo.config.opengraph_image.attached?
      SellRepo.config.opengraph_image.url
    end
  end
end
