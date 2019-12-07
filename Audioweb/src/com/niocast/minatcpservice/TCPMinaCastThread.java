/**  
 * @Title:  MinaCastThread.java   
 * @Package com.niocast.cast   
 * @Description:    TODO(用一句话描述该文件做什么)   
 * @author: Shuofang     
 * @date:   2019年1月10日 下午3:22:16   
 * @version V1.0 
 * @Copyright: 2019 
 */
package com.niocast.minatcpservice;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.Locale;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.mina.core.filterchain.DefaultIoFilterChainBuilder;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.filter.executor.ExecutorFilter;
import org.apache.mina.filter.logging.LogLevel;
import org.apache.mina.filter.logging.LoggingFilter;
import org.apache.mina.transport.socket.SocketSessionConfig;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Shuofang
 *	TODO
 */
public class TCPMinaCastThread extends Thread {
	private final static int NUMBER_OF_CORES = Runtime.getRuntime().availableProcessors(); // cpu核心数
	private final static long KEEP_ALIVE_TIME = 3L; //线程活跃时间
	private final static TimeUnit KEEP_ALIVE_TIME_UNIT = TimeUnit.SECONDS; //线程活跃时间单位
	private BlockingQueue<Runnable> mWorkQueue = new LinkedBlockingQueue<Runnable>(); // 消息处理队列
	private ThreadFactory Factory; //线程池工厂类实例
	private TCPMinaCastHandler mHandler; //通信处理器
	private NioSocketAcceptor Acceptor; //分发器
	private Integer port; // 端口
    private static Logger logger = LoggerFactory.getLogger(TCPMinaCastThread.class);
    /**
	 * 
	 * TODO 无地址初始化
	 * 时间：2019年1月10日
	 */
	public TCPMinaCastThread(int loginport) {
		// TODO Auto-generated constructor stub
		this.port = loginport;
		Factory = new MyThreadFactory(1,"ClientThread-");
	}
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		mHandler = new TCPMinaCastHandler();
		// TODO Auto-generated method stub
		// ** loginAcceptor设置
        Acceptor = new NioSocketAcceptor();
		DefaultIoFilterChainBuilder chain = Acceptor.getFilterChain();
		LoggingFilter loggingFilter = new LoggingFilter();
		loggingFilter.setMessageSentLogLevel(LogLevel.NONE);
		loggingFilter.setMessageReceivedLogLevel(LogLevel.NONE);
		chain.addLast("logger", loggingFilter);
		// 此行代码能让你的程序整体性能提升10倍
		chain.addLast("ClientThread", new ExecutorFilter(new ThreadPoolExecutor(2,
				NUMBER_OF_CORES > 4?NUMBER_OF_CORES:4, KEEP_ALIVE_TIME, KEEP_ALIVE_TIME_UNIT,
				mWorkQueue,Factory)));
		Acceptor.setReuseAddress(true);//加上这句话，避免重启时提示地址被占用
        // 设置MINA2的IoHandler实现类
        Acceptor.setHandler(mHandler);
        logger.info("创建 Acceptor");
        // 设置会话超时时间（单位：毫秒），不设置则默认是10秒，请按需设置
        //Acceptor.setSessionRecycler(new ExpiringSessionRecycler(8 * 1000));
        // ** TCP通信配置
		SocketSessionConfig cfg = (SocketSessionConfig) Acceptor.getSessionConfig();  
		Acceptor.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, 30);//超时30秒空闲，断开连接
		//Acceptor.getSessionConfig().setUseReadOperation(true);
		cfg.setSoLinger(0);
        // ** UDP通信配置
       /* DatagramSessionConfig logindcfg = Acceptor.getSessionConfig();
        logindcfg.setReuseAddress(true);*/
        // 设置输入缓冲区的大小，压力测试表明：调整到2048后性能反而降低
        //logindcfg.setReceiveBufferSize(1024);
        // 设置输出缓冲区的大小，压力测试表明：调整到2048后性能反而降低
        //logindcfg.setSendBufferSize(1024);
        //acceptor.bind(arg0, arg1);
        // ** UDP服务端开始侦听
        //acceptor.bind(new InetSocketAddress(6970));
      /*  ////** netheartAcceptor设置
        netheartAcceptor = new NioDatagramAcceptor();
        // 此行代码能让你的程序整体性能提升10倍
        netheartAcceptor.getFilterChain()
                .addLast("netheartIOThreadPool", new ExecutorFilter(Executors.newCachedThreadPool())); 
        // 设置MINA2的IoHandler实现类
        netheartAcceptor.setHandler(mHandler);
        // 设置会话超时时间（单位：毫秒），不设置则默认是10秒，请按需设置
        netheartAcceptor.setSessionRecycler(new ExpiringSessionRecycler(8 * 1000));
         */
        try {
			Acceptor.bind(new InetSocketAddress(port));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
     
        logger.info("Mina TCP服务器正在端口 "+port+" 上监听中...");
	}
	/**
	 * @return the mHandler
	 */
	public TCPMinaCastHandler getmHandler() {
		return mHandler;
	}
	/**
	 * @return the acceptor
	 */
	public NioSocketAcceptor getAcceptor() {
		return Acceptor;
	}

	private class MyThreadFactory implements ThreadFactory {
		private AtomicInteger threadNumberAtomicInteger = new AtomicInteger(1);
		private String name = "ThreadFactory";
		public MyThreadFactory(int size,String name) {
			// TODO Auto-generated constructor stub
			this.name = name;
			threadNumberAtomicInteger = new AtomicInteger(size);
		}
		@Override
		public Thread newThread(Runnable r) {
			Thread thread=  new Thread(r,String.format(Locale.CHINA,"%s%d",name,threadNumberAtomicInteger.getAndIncrement()));
            /* thread.setDaemon(true);//是否是守护线程
            thread.setPriority(Thread.NORM_PRIORITY);//设置优先级 1~10 有3个常量 默认 Thread.MIN_PRIORITY*/
			return thread;
		}
	}

}
