ALTER TABLE znote_accounts
ADD twitchuser varchar(256);

ALTER TABLE znote_accounts
ADD affiliatecode varchar(256);

ALTER TABLE znote_accounts
ADD affiliated varchar(256);

CREATE TABLE IF NOT EXISTS `znote_affiliate_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `affiliator_account_id` int(11) NOT NULL,
  `affiliated_account_id` int(11) NOT NULL,
  `points_given` int(10) NOT NULL,
  `paid_money` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;