require "watir"
require "logger"
require "rubygems"
require 'colorize'
require "net/ping"

module NewAccount
  def new_account(browser, name:, surname:, email:, password:, newsletter:, gdpr:, club:, register_me:)
    click_registration(browser)
    fill_in_details(browser, name: name, surname: surname, email: email, password: password, newsletter: newsletter, gdpr: gdpr, club: club)
    register_me(browser, register_me: register_me)
  end

  def click_registration(browser)
    registration_btn = browser.element(class: "authorization-link").element(text: "Registrovat")
    registration_btn.click
    sleep(1)
  end

  def fill_in_details (browser, name:, surname:, email:, password:, newsletter:, gdpr:, club:)
    fill_name = browser.element(class: "field field-name-firstname required").text_field(type: "text")
    fill_name.set(name)

    fill_surname = browser.element(class: "field field-name-lastname required").text_field(type: "text")
    fill_surname.set(surname)

    fill_email = browser.element(class: "field required").text_field(type: "email")
    fill_email.set(email)

    fill_password = browser.element(class: "field password required").text_field(type: "password")
    fill_password.set(password)

    fill_confirmation_password = browser.element(class: "field confirmation required").text_field(id: "password-confirmation")
    fill_confirmation_password.set(password)

    set_newsletter = browser.element(class: "field choice newsletter").element(name: "is_subscribed")
    set_newsletter.click if newsletter == true

    set_gdpr = browser.element(id: "gdpr-personnalized-suggestions-box").element(name: "personnalized_suggestions")
    set_gdpr.click if gdpr == true

    set_club = browser.element(id: "gdpr-third-party-box").element(name: "third_party")
    set_club.click if club == true
  end

  def register_me(browser, register_me:)
    register_btn = browser.element(class: "action submit primary")
    register_btn.click if register_me == true
  end
end

=begin
EXAMPLE:
include OpenBrowser
include NewAccount

mrv = open_browser(url: "https://www.new.mameradivlasy.cz/")
new_account(
  mrv,
  name: "autotest_name",
  surname: "autotest_surname",
  email: "autotest_email@mailinator.com",
  password: "autotest_password",
  newsletter: true,
  gdpr: true,
  club: true,
  register_me: true
  )
=end