class ContactMailer < ApplicationMailer
    def contact_mail(feed)
        @feed = feed
        mail to: "moka0000@outlook.jp", subject: "投稿の確認メール"
    end
end
