 DECLARE
      v_mailsever_host VARCHAR2(30) := 'smtp.gmail.com';
      v_mailsever_port PLS_INTEGER  := 587;
      l_mail_conn  UTL_SMTP.CONNECTION;
    BEGIN
      l_mail_conn := UTL_SMTP.OPEN_CONNECTION( v_mailsever_host, v_mailsever_port);
    END;
/

SELECT host, lower_port, upper_port, acl FROM dba_network_acls ;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'acl_test_for_scott.xml', 
    description  => 'A test of the ACL functionality',
    principal    => 'SCOTT',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl => 'acl_test_for_scott.xml',
    host => 'smtp.gmail.com', 
    lower_port => 587,
    upper_port => NULL); 
END;
/

DECLARE
      v_mailsever_host VARCHAR2(30) := 'smtp.mail.com';
      v_mailsever_port PLS_INTEGER  := 587;
      l_mail_conn  UTL_SMTP.CONNECTION;
    BEGIN
      l_mail_conn := UTL_SMTP.OPEN_CONNECTION( v_mailsever_host, v_mailsever_port);
    END;
  /  





CREATE OR REPLACE PROCEDURE send_mail (p_to        IN VARCHAR2,
                                       p_from      IN VARCHAR2,
                                       p_message   IN VARCHAR2,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 587)
AS
  l_mail_conn   UTL_SMTP.connection;
BEGIN
  l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
  UTL_SMTP.helo(l_mail_conn, p_smtp_host);
  UTL_SMTP.mail(l_mail_conn, p_from);
  UTL_SMTP.rcpt(l_mail_conn, p_to);
  UTL_SMTP.data(l_mail_conn, p_message || UTL_TCP.crlf || UTL_TCP.crlf);
  UTL_SMTP.quit(l_mail_conn);
END;
/
show error


declare
    l_connection utl_smtp.connection;
begin
    l_connection := utl_smtp.open_connection(
                        host => 'smtp.gmail.com',
                        port => 587,
                        wallet_path => 'file:/oracle/email',
                        wallet_password => '123456rkg',
                        secure_connection_before_smtp => false);
    utl_smtp.ehlo( l_connection, 'smtp.gmail.com');
    utl_smtp.starttls(l_connection);
    utl_smtp.auth(l_connection,
                   'skgs01',
                   'lsogk0780004');
end;
/
