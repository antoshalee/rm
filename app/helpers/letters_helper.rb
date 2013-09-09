module LettersHelper
  def get_brd_css_class_by_letter_color color
    @brd_css_classes ||= {white: nil, black: "s-black-bkg ", brown: "dark-brown-bkg", gray: "gray87-bkg", bistre: "bistre-bkg"}
    @brd_css_classes[color.to_sym]
  end
end