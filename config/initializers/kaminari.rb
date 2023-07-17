Kaminari.configure do |config|
    config.page_method_name = :per_page_kaminari
    config.param_name = :pagina
    config.default_per_page = 12
    config.window = 4
    config.outer_window = 1
    config.left = 1
    config.right = 1
    config.page_method_name = :per_page_kaminari
    config.param_name = :pagina
    config.outer_window = 0
    config.inner_window = 2
    config.theme = :bootstrap
  end
  