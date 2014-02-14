require ["envelope", "imapflags", "fileinto", "reject", "notify", "vacation", "regex", "relational", "comparator-i;ascii-numeric", "body", "copy"];

if header :contains ["x-resolved-to"] "+personalitysentitem-20160237@" {
  setflag "\\Seen";
  fileinto "INBOX.Sent Items";
  stop;
  }
if not header :contains ["X-Spam-known-sender"] "yes" {
if allof(
  header :contains ["X-Backscatter"] "yes",
  not header :matches ["X-LinkName"] "*"
) {
  fileinto "INBOX.Junk Mail";
  stop;
}
if  header :value "ge" :comparator "i;ascii-numeric" ["X-Spam-score"] ["5"]  {
  fileinto "INBOX.Junk Mail";
  stop;
}
}
if header :is ["list-id", "list-post"] ["ror2ru.googlegroups.com", "<ror2ru.googlegroups.com>"] {
  fileinto "INBOX.ror2ru_list";
} elsif address :all :is "from" "noreply@youtube.com" {
  fileinto "INBOX.youtube_feeds";
} elsif address :all :is "from" "notifications@disqus.net" {
  fileinto "INBOX.disqus_feeds";
} elsif header :is ["list-id", "list-post"] ["spb-archlinux.googlegroups.com", "<spb-archlinux.googlegroups.com>"] {
  fileinto "INBOX.lists";
} elsif header :is ["list-id", "list-post"] ["ru_bzr.googlegroups.com", "<ru_bzr.googlegroups.com>"] {
  fileinto "INBOX.lists";
} elsif header :is ["list-id", "list-post"] ["django-russian.googlegroups.com", "<django-russian.googlegroups.com>"] {
  fileinto "INBOX.django_russian_list";
} elsif header :is ["list-id", "list-post"] ["erlang-russian.googlegroups.com", "<erlang-russian.googlegroups.com>"] {
  fileinto "INBOX.erlang_russian_list";
} elsif address :all :is "from" "support@diamondcard.us" {
  fileinto "INBOX.lists";
} elsif header :is ["list-id", "list-post"] ["instiki-users.rubyforge.org", "<instiki-users.rubyforge.org>"] {
  fileinto "INBOX.lists";
} elsif header :regex "from" "(^|,)[[:space:]]*\"?Jolla[[:space:]]+Users[[:space:]]+Blog\"?[[:space:]]*<" {
  fileinto "INBOX.sailfishos_feeds";
} elsif header :is ["list-id", "list-post"] ["info-member.gnu.org", "<info-member.gnu.org>"] {
  fileinto "INBOX.fsf_lists";
} elsif address :all :is "from" "info@defectivebydesign.org" {
  fileinto "INBOX.fsf_lists";
} elsif address :all :is "from" "rms-assist@gnu.org" {
  fileinto "INBOX.fsf_lists";
} elsif address :all :is "from" "sales@fsf.org" {
  fileinto "INBOX.fsf_lists";
} elsif header :is ["list-id", "list-post"] ["exim-users.mailground.net", "<exim-users.mailground.net>"] {
  fileinto "INBOX.exim_users_list";
} elsif header :is ["list-id", "list-post"] ["spbhug.googlegroups.com", "<spbhug.googlegroups.com>"] {
  fileinto "INBOX.lists";
} elsif header :is ["list-id", "list-post"] ["emacs-on-rails.googlegroups.com", "<emacs-on-rails.googlegroups.com>"] {
  fileinto "INBOX.emacs_community";
} elsif header :is ["list-id", "list-post"] ["spblinux.googlegroups.com", "<spblinux.googlegroups.com>"] {
  fileinto "INBOX.spblinux_list";
} elsif header :is ["list-id", "list-post"] ["pgsql-ru-general.postgresql.org", "<pgsql-ru-general.postgresql.org>"] {
  fileinto "INBOX.lists";
} elsif header :is ["list-id", "list-post"] ["thinking-sphinx.googlegroups.com", "<thinking-sphinx.googlegroups.com>"] {
  fileinto "INBOX.lists";
} elsif address :all :is ["to", "cc", "resent-to", "x-delivered-to"] "news@lists.molinos.ru" {
  fileinto "INBOX.molinos";
} elsif header :is ["list-id", "list-post"] ["gentoo-user-ru.gentoo.org", "<gentoo-user-ru.gentoo.org>"] {
  fileinto "INBOX.gentoo_community";
} elsif allof (header :is ["list-id", "list-post"] ["medappsupport.hospital-systems.com", "<medappsupport.hospital-systems.com>"],
               anyof (header :is "X-Redmine-Sender" "danil",
                      header :contains "Subject" "(Ready for Deploy)",
                      header :contains "Subject" "(Done)")) {
  fileinto "INBOX.sieve_to_trash";
} elsif header :contains ["x-resolved-to"] "+chatlogs@" {
  addflag "$ChatLog";
  addflag "\\Seen";
  fileinto "INBOX.Chats";
  removeflag "$ChatLog";
  removeflag "\\Seen";
}
