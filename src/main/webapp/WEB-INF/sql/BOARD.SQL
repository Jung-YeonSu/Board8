CREATE TABLE BOARD(
	IDX	         NUMBER(8,0)  				PRIMARY KEY,
	MENU_ID      VARCHAR2(6)
		REFERENCES MENUS (MENU_ID),
	TITLE        VARCHAR2(300 BYTE)   NOT NULL,
	CONTENT      VARCHAR2(4000 BYTE),
	WRITER       VARCHAR2(12),
	REGDATE      DATE                 DEFAULT SYSDATE,
	HIT          NUMBER(9,0)          DEFAULT 0
);

DROP TABLE BOARD;

INSERT INTO board (
    IDX,
    menu_id,
    title,
    content,
    writer
) VALUES (
    (SELECT NVL(MAX(IDX),0)+1 FROM BOARD),'MENU02','국가유공자 빌런','진짜 뭐하는 사람일까','대박박'
);

COMMIT;

SELECT NVL(MAX(IDX),0)+1 FROM BOARD;

	SELECT     DISTINCT(MENU_ID)
    FROM      BOARD;
  
     

  	SELECT                  ROWNUM IDX
							,MENU_ID
							,TITLE
							,CONTENT
							,WRITER
							,TO_CHAR(REGDATE,'YYYY-MM-DD') REGDATE
							,HIT
  	 FROM      BOARD
  	WHERE MENU_ID = 'MENU02' ORDER BY IDX DESC;
    
    
    SELECT                   IDX
							,MENU_ID
							,TITLE
							,CONTENT
							,WRITER
							,TO_CHAR(REGDATE,'YYYY-MM-DD') REGDATE
							,HIT
  	 FROM      BOARD
  	 ORDER BY IDX DESC;
    
    SELECT ROWNUM IDX, TITLE, CONTENT, WRITER, REGDATE, HIT FROM(
    	SELECT     IDX
							,MENU_ID
							,TITLE
							,CONTENT
							,WRITER
							,TO_CHAR(REGDATE,'YYYY-MM-DD') REGDATE
							,HIT
  	 FROM      BOARD
     WHERE MENU_ID = 'MENU01'
  	 ORDER BY  IDX ASC
    )
    ORDER BY IDX DESC;
    
    DELETE (SELECT * FROM BOARD WHERE MENU_ID = 'MENU01') WHERE IDX=1;

    