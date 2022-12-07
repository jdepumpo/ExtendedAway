module AvatarHelper
  def cloudinary_avatar(user)
    if user.photo.attached?
      cl_image_path user.photo.key
    else
      image_tag "noPicAvatar.png"
    end
  end

  def navbar_avatar(user)
    if user.photo.attached?
     cl_image_tag user.photo.key, class: "avatar dropdown-toggle", id: "navbarDropdown", data: { bs_toggle: "dropdown" }, 'aria-haspopup': true, 'aria-expanded': false
    else
     image_tag "noPicAvatar.png", class: "avatar dropdown-toggle", id: "navbarDropdown", data: { bs_toggle: "dropdown" }, 'aria-haspopup': true, 'aria-expanded': false
    end
  end

  def friend_avatar(user)
    if user.photo.attached?
      cl_image_tag user.photo.key, size: '69x69', class:"kingofhelpers"
     else
      image_tag "noPicAvatar.png", class: "avatar dropdown-toggle", id: "navbarDropdown", data: { bs_toggle: "dropdown" }, 'aria-haspopup': true, 'aria-expanded': false
     end
  end
end
