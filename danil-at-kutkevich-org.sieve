require ["envelope", "imapflags", "fileinto", "reject", "notify", "vacation", "regex", "relational", "comparator-i;ascii-numeric", "body", "copy"];

if header :contains ["x-resolved-to"] "+personalitysentitem-20160237@" {
  setflag "\\Seen";
  fileinto "INBOX.Sent Items";
  stop;
}
if anyof(allof(address :all :is "from" "CardMaster@vtb-sz.ru",
               address :all :is "to" "danila@kutkevich.com"),
         address :all :is "from" "NoteBookReview@lists.techtarget.com") {
  discard;
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
} elsif header :contains "list-id" "devel.lists.sailfishos.org" {
  fileinto "INBOX.sailfishos_list";
} elsif header :is ["list-id", "list-post"] ["info-member.gnu.org", "<info-member.gnu.org>"] {
  fileinto "INBOX.fsf_lists";
} elsif address :all :is "from" "info@defectivebydesign.org" {
  fileinto "INBOX.fsf_lists";
} elsif address :all :is "from" "rms-assist@gnu.org" {
  fileinto "INBOX.fsf_lists";
} elsif address :all :is "from" "sales@fsf.org" {
  fileinto "INBOX.fsf_lists";
} elsif header :contains "list-id" "exim-users.mailground.net" {
  fileinto "INBOX.exim_lists";
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
} elsif header :is "list-id" "gentoo-user-ru.gentoo.org" {
  fileinto "INBOX.gentoo_community";
} elsif address :all :is "from" "contact@humblebundle.com" {
  fileinto "INBOX.humblebundle_list";
} elsif allof (header :is ["list-id", "list-post"] ["medappsupport.hospital-systems.com", "<medappsupport.hospital-systems.com>"],
               anyof (header :is "X-Redmine-Sender" "danil",
                      header :contains "Subject" "(Ready for Deploy)",
                      header :contains "Subject" "(Done)")) {
  fileinto "INBOX.sieve_to_trash";
} elsif allof (address :all :is "from" "no-reply@jolla.com",
               header :contains "Subject" "together.jolla.com") {
  fileinto "INBOX.jolla_community";
} elsif header :is ["list-id", "list-post"] ["<stumpwm-devel.nongnu.org>", "<mailto:stumpwm-devel@nongnu.org>"] {
  fileinto "INBOX.stumpwm_list";
} elsif header :contains "list-id" "awesome.naquadah.org" {
  fileinto "INBOX.awesome_list";
} elsif header :contains "list-id" "awesome-devel.naquadah.org" {
  fileinto "INBOX.awesome_devel_list";
} elsif header :contains "list-id" "golang-ru.googlegroups.com" {
  fileinto "INBOX.golang-ru_list";
} elsif header :contains "list-id" "dev.suckless.org" {
  fileinto "INBOX.suckless_dev";
} elsif header :contains "Subject" "[Fail2Ban]" {
  fileinto "INBOX.fail2ban";
} elsif allof (address :all :is "from" "noreply@kutkevich.org",
               header :contains "Subject" "[twitter]",
               anyof (body :text :contains "RT @PostCSS:",
                      body :text :contains "RT @StationCDRKelly:",
                      body :text :contains "RT @sindresorhus:")) {
  fileinto "INBOX.sieve_to_trash";
} elsif allof (address :all :is "from" "noreply@kutkevich.org",
               header :contains "Subject" "[twitter]") {
  fileinto "INBOX.twitter";
} elsif allof (address :all :is "from" "contact@luadns.com",
               header :contains "Subject" "[LuaDNS]: Build completed") {
  fileinto "INBOX.luadns";
} elsif allof (address :all :is "from" "cloud@fruux.com",
               header :contains "Subject" "No events") {
  fileinto "INBOX.sieve_to_trash";
} elsif allof (address :all :is "from" "notifier@mail.rollbar.com",
               header :contains "Subject" "[hl7rus]") {
  fileinto "INBOX.waveaccess";
} elsif allof (address :all :is "from" "notifications@travis-ci.org",
               header :contains "Subject" ["Passed: ", "Fixed: "]) {
  fileinto "INBOX.sieve_to_trash";
} elsif allof (address :all :is "from" "no-reply@webzilla.com",
               header :contains "Subject" ["Webzilla - Invoice", "is paid"],
               body :text :contains "Total due: EUR 0.00") {
  fileinto "INBOX.sieve_to_trash";
} elsif allof (header :contains "list-id" "salemed.HealthSamurai.github.com",
               header :contains "from" "HealthSamurai TeamCity Server",
               anyof (body :text :contains "is now running",
                      body :text :contains "outcome was **SUCCESS**")) {
  fileinto "INBOX.sieve_to_trash";
} elsif allof (header :contains "list-id" "salemed.HealthSamurai.github.com",
               header :contains "from" "HealthSamurai TeamCity Server") {
  fileinto "INBOX.salemed_ci";
} elsif header :contains ["x-resolved-to"] "+chatlogs@" {
  addflag "$ChatLog";
  addflag "\\Seen";
  fileinto "INBOX.Chats";
  removeflag "$ChatLog";
  removeflag "\\Seen";
}
