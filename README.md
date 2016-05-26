# Deploy

## Version

v2.0.0

## Production

```
mina master deploy
mina master server:restart
```

## 清空缓存

```
RAILS_ENV=production bundle exec rake tmp:clear
```

## 测试邮件发送

```
RAILS_ENV=production bundle exec rails c
I18n.locale = :'zh-CN'
Spree::TestMailer.test_email("hi@liwei.me").deliver
o = Spree::Order.last
Spree::OrderMailer.confirm_email(o.id).deliver
Spree::OrderMailer.cancel_email(o.id).deliver
s = Spree::Shipment.last
Spree::ShipmentMailer.shipped_email(s).deliver
u = Spree::User.first
Spree::UserMailer.confirmation_instructions(u,u.confirmation_token).deliver
Spree::UserMailer.reset_password_instructions(u,u.reset_password_token).deliver
```
