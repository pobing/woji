OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, "2300889339", "15434969d2beeed8847b441ed356fbf3"
  provider :github, "c60ba3a8b1cdd3861e63","e12c52628d93387ae6ba1f8b7557615bc23e3954",scope:"user"
  provider :tqq, "100722995","c31b0e684c0fa2c8cfd9463737a60d9a"
end