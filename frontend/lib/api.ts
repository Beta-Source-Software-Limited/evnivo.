// All backend URLs are centrally defined here so replacing the backend is simple.
export const API = process.env.NEXT_PUBLIC_API_URL ?? 'http://127.0.0.1:8000/api';
export type Category = {id:number;name:string;slug:string;icon:string};
export type TicketType = {id:number;name:string;price:string;capacity:number;available:number;active:boolean};
export type Event = {id:number;title:string;slug:string;summary:string;description:string;venue:string;city:string;address:string;start_at:string;end_at:string;image:string|null;featured:boolean;category:Category;ticket_types:TicketType[];starting_price:string|null};
export type Booking = {reference:string;event:Event;ticket_type:TicketType;quantity:number;total:string;status:string;created_at:string;tickets:{code:string;checked_in_at:string|null}[]};
export type Paginated<T> = {count:number;next:string|null;previous:string|null;results:T[]};
export async function api<T>(path:string, init:RequestInit = {}, token?:string):Promise<T>{
 const res=await fetch(`${API}${path}`,{...init,cache:'no-store',headers:{'Content-Type':'application/json',...(token?{Authorization:`Token ${token}`}:{ } ),...init.headers}});
 if(!res.ok){let error:unknown;try{error=await res.json()}catch{error=null}const detail=error&&typeof error==='object'?Object.entries(error).map(([k,v])=>k==='detail'?String(v):`${k}: ${Array.isArray(v)?v.join(', '):String(v)}`).join(' · '):`Request failed (${res.status})`;throw new Error(detail)}
 return res.json() as Promise<T>;
}
export const formatMoney=(n:string|number)=>`৳${Number(n).toLocaleString('en-BD',{maximumFractionDigits:0})}`;
export const formatDate=(date:string)=>new Date(date).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric',timeZone:'Asia/Dhaka'});
export const formatTime=(date:string)=>new Date(date).toLocaleTimeString('en-US',{hour:'numeric',minute:'2-digit',timeZone:'Asia/Dhaka'});
export const fallbackImage='https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1000&q=80';
export function getToken(){return typeof window==='undefined'?'':localStorage.getItem('evnivo_token')??''}
export function saveToken(token:string){localStorage.setItem('evnivo_token',token)}
export function logout(){localStorage.removeItem('evnivo_token')}
