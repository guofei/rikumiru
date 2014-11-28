# coding: utf-8
class Mailmaga < ActiveRecord::Base
  validates :email, :email_format => {:message => ' メールアドレスの形式が不適切です'}
end
